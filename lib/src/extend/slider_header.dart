import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/utils.dart';

class SliderHeader {
  final DateTime minDateTime, maxDateTime, initialDateTime;
  SliderHeader(
      {Key key,
      @required this.minDateTime,
      @required this.maxDateTime,
      @required this.initialDateTime});

  Widget build(BuildContext context) {
    int yearCount = (getMonthIndex(minDateTime, maxDateTime) + 1) ~/ 12 + 1;

    List<String> years = List.generate(yearCount, (index) {
      return (minDateTime.year + index).toString() + "年";
    }).toList();

    List<String> months = List.generate(12, (index) {
      return (index + 1).toString() + "月";
    }).toList();

    return null;
  }
}
