import 'package:flutter/widgets.dart';
import 'package:oh_datepicker/src/model/index.dart';

import 'dart:ui' as ui;

import 'package:oh_datepicker/src/render/render.dart';
import 'package:oh_datepicker/src/render/descriptor.dart';
import 'package:flutter/material.dart';

class View {
  static Widget header() {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _HeaderPainter(headers: Model.header()),
      ),
    );
  }

  static Widget month(DateTime day) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _MonthPainter(
            days: Model.month(day),
            currentMonth: DateTime(day.year, day.month)),
      ),
    );
  }
}

class _MonthPainter extends CustomPainter {
  final List<List<DateTime>> days;
  final DateTime currentMonth;
  _MonthPainter({this.days, @required this.currentMonth});
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
  bool shouldRepaint(_MonthPainter oldDelegate) => true;
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
