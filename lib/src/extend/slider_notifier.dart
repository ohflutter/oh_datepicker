import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

typedef ValueCallback<T> = void Function(T t);

class SliderNotifier<T> {
  ObserverList<ValueCallback<T>> _listeners = ObserverList<ValueCallback<T>>();

  void addListener(ValueCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners.add(listener);
  }

  void removeListener(ValueCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners.remove(listener);
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw FlutterError('A $runtimeType was used after being disposed.\n'
            'Once you have called dispose() on a $runtimeType, it can no longer be used.');
      }
      return true;
    }());
    return true;
  }

  void notifyListeners(T value) {
    assert(_debugAssertNotDisposed());
    if (_listeners != null) {
      final List<ValueCallback<T>> localListeners =
          List<ValueCallback<T>>.from(_listeners);
      for (ValueCallback<T> listener in localListeners) {
        try {
          if (_listeners.contains(listener)) listener(value);
        } catch (exception, stack) {
          FlutterError.reportError(FlutterErrorDetails(
            exception: exception,
            stack: stack,
            library: 'foundation library',
            context: 'while dispatching notifications for $runtimeType',
            informationCollector: (StringBuffer information) {
              information.writeln('The $runtimeType sending notification was:');
              information.write('  $this');
            },
          ));
        }
      }
    }
  }
}
