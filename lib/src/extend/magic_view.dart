import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MagicView extends StatefulWidget {
  final double height, width;
  final String initialValue;

  const MagicView({Key key, this.height, this.width, this.initialValue})
      : super(key: key);
  @override
  MagicViewState createState() => MagicViewState();
}

class MagicViewState extends State<MagicView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _translate = 0.0;
  String _current = "", _next;

  @override
  void initState() {
    super.initState();
    _next = widget.initialValue;
    initAnimation();
  }

  void initAnimation() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = new Tween(begin: 0.0, end: widget.height).animate(_controller);

    _animation.addListener(() {
      setState(() {
        this._translate = _animation.value;
      });
    });

    _controller.forward();
  }

  void next(String next) {
    setState(() {
      _current = _next;
      _next = next;
    });

    _controller.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(MagicView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 当前值在位置0
    // 新的值在上面或者下面
    RegExp exp = new RegExp(r"(\d+)");

    int _nextFind = (int.parse(exp.stringMatch(_next)));
    int _currentFind = (int.parse(exp.stringMatch(_current) ?? "0"));

    bool isTop = _nextFind.compareTo(_currentFind) > 0;
    double realTranlate = (isTop ? -_translate : _translate);

    if (_nextFind.compareTo(_currentFind) == 0) {
      realTranlate = 0;
    }

    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: realTranlate,
            height: widget.height,
            width: widget.width,
            child: SizedBox.expand(
              child: Center(
                child: Text(
                  _current,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: (isTop ? widget.height : -widget.height) + realTranlate,
            height: widget.height,
            width: widget.width,
            child: SizedBox.expand(
              child: Center(
                child: Text(
                  _next,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
