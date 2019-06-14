import 'package:flutter/material.dart';
import 'package:oh_datepicker/oh_datepicker.dart';
import 'package:oh_datepicker/src/extend/slider_notifier.dart';
import 'dart:ui' as ui;

class SliderCore extends StatefulWidget {
  final SliderNotifier notifier;
  final String next;
  final String current;

  const SliderCore({this.notifier, this.next, this.current});

  @override
  _SliderCoreState createState() => _SliderCoreState();
}

class _SliderCoreState extends State<SliderCore>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double translate = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = new Tween(begin: 0.0, end: 14.0).animate(_controller)
      ..addListener(() {
        print(_animation.value);
        setState(() {
          translate:
          _animation.value;
        });
      });

    _controller.forward();

    widget.notifier.addListener((value) {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _Painter(translate, widget.next, widget.current),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final double translate;
  final String next, current;

  _Painter(this.translate, this.next, this.current);
  @override
  void paint(Canvas canvas, Size size) {
    Render r = new Render(canvas, size);

    // 绘制背景使用默认位置
    r.rect(r.defaultDescriptor, color: Colors.blueAccent);
    // 绘制文字
    const fontSize = 14.0;
    r.text(r.defaultDescriptor,
        text: next,
        offset: Offset(0, -4),
        textStyle: ui.TextStyle(fontSize: fontSize, color: Colors.white));
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) =>
      oldDelegate.translate != translate;
}
