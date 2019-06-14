import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/extend/slider_core.dart';
import 'package:oh_datepicker/src/extend/slider_notifier.dart';

class SliderHeader extends StatelessWidget {
  final DateTime minDateTime, maxDateTime, initialDateTime;
  SliderHeader(
      {Key key,
      @required this.minDateTime,
      @required this.maxDateTime,
      @required this.initialDateTime});

  Widget build(BuildContext context) {
    SliderNotifier<String> sliderNotifier = new SliderNotifier<String>();
    Widget slider = new SliderCore(
      notifier: sliderNotifier,
      next: "12月",
      current: "",
    );

    return Container(
      height: 14.0,
      width: 40.0,
      child: slider,
    );
  }
}
