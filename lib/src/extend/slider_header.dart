import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderHeader extends StatelessWidget {
  final DateTime minDateTime, maxDateTime, initialDateTime;

  SliderHeader(
      {Key key,
      @required this.minDateTime,
      @required this.maxDateTime,
      @required this.initialDateTime});

  Widget build(BuildContext context) {
    return Container(
      height: 14.0,
      width: 40.0,
    );
  }
}
