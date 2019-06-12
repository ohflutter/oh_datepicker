import 'dart:ui' as ui;

import 'package:oh_datepicker/src/utils.dart';

import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/render/render.dart';
import 'package:oh_datepicker/src/render/descriptor.dart';

import 'dart:ui';

class _PagePainter extends CustomPainter {
  final List<List<DateTime>> days;
  final DateTime currentMonth;
  _PagePainter({this.days, @required this.currentMonth});
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0) {
      print("元素宽度不能为0, 如果需要充满屏幕,请设置宽度为double.infinity");
    }
    Render r = new Render(canvas, size);
    // background
    r.rect(r.defaultDescriptor, color: Colors.white70);

    // day
    double itemWidth = size.width / days[0].length;
    double itemHeight = size.height / days.length;
    const fontSize = 14.0;
    for (int week = 0; week < days.length; week++) {
      for (int day = 0; day < days[week].length; day++) {
        Descriptor d = Descriptor(
            day * itemWidth, week * itemHeight, itemWidth, itemHeight);

        DateTime item = days[week][day];

        r.text(d,
            text: item.day.toString(),
            textStyle: ui.TextStyle(fontSize: fontSize, color: Colors.black),
            offset: Offset(d.x, d.y + (d.height - fontSize) / 2 - 3));
      }
    }
  }

  @override
  bool shouldRepaint(_PagePainter oldDelegate) => true;
}

class _HeaderPainter extends CustomPainter {
  final List<String> headers;
  _HeaderPainter({this.headers});
  @override
  void paint(Canvas canvas, Size size) {
    Render r = new Render(canvas, size);
    // background
    r.rect(r.defaultDescriptor, color: Colors.blueAccent);

    // header
    double itemWidth = size.width / headers.length;
    double itemHeight = size.height;
    const fontSize = 14.0;
    for (int index = 0; index < headers.length; index++) {
      Descriptor d = Descriptor(index * itemWidth, 0, itemWidth, itemHeight);

      r.text(d,
          text: headers[index],
          offset: Offset(d.x, (d.height - fontSize) / 2 - 3),
          textStyle: ui.TextStyle(fontSize: fontSize, color: Colors.white));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MonthView {
  /// 生成日期的二维数组
  ///
  /// 例如: 2019-06
  ///
  /// [
  ///
  ///  [05-27, 05-28, 05-29, 05-30, 05-31, 06-01, 06-02],
  ///
  ///  [06-03, 06-04, 06-05, 06-06, 06-07, 06-08, 06-09],
  ///
  ///  [06-10, 06-11, 06-12, 06-13, 06-14, 06-15, 06-16],
  ///
  ///  [06-17, 06-18, 06-19, 06-20, 06-21, 06-22, 06-23],
  ///
  ///  [06-24, 06-25, 06-26, 06-27, 06-28, 06-29, 06-30],
  ///
  /// ]
  ///
  static List<List<DateTime>> generatePage(DateTime day) {
    DateTime firstDay = DateTime(day.year, day.month);
    List<List<DateTime>> result = [];
    List<DateTime> firstWeek = [];
    // 本月第一周
    int firstDayOffset = firstDay.weekday - 1;
    for (int i = firstDayOffset; i > 0; i--) {
      firstWeek.add(firstDay.subtract(Duration(days: i)));
    }
    for (int i = firstDay.weekday; i <= 7; i++) {
      firstWeek.add(firstDay.add(Duration(days: i - firstDay.weekday)));
    }
    result.add(firstWeek);
    // 本月其他周
    DateTime startDay = firstWeek[firstWeek.length - 1].add(Duration(days: 1));
    DateTime lastDay = getLastDayOfMonth(firstDay);
    while (startDay.compareTo(lastDay) <= 0) {
      if (result[result.length - 1].length == 7) {
        result.add([]);
      }

      result[result.length - 1].add(startDay);

      startDay = startDay.add(Duration(days: 1));
    }
    // 本月最后一周
    int lastDayOffset = 7 - lastDay.weekday;
    for (int i = 1; i <= lastDayOffset; i++) {
      result[result.length - 1].add(lastDay.add(Duration(days: i)));
    }
    return result;
  }

  static List<String> generateHeader() {
    return ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
  }

  static Widget generatePageView(DateTime day) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _PagePainter(
            days: MonthView.generatePage(day),
            currentMonth: DateTime(day.year, day.month)),
      ),
    );
  }

  static Widget generateHeaderView() {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _HeaderPainter(headers: MonthView.generateHeader()),
      ),
    );
  }
}
