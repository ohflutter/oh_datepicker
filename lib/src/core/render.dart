import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/core/descriptor.dart';

class Render {
  final Canvas canvas;
  final Size size;

  Render(this.canvas, this.size);

  void circle(Descriptor d) {}

  /// 仅支持添加单行文本
  void text(Descriptor d,
      {TextAlign textAlign,
      FontWeight fontWeight,
      FontStyle fontStyle,
      ui.TextStyle textStyle,
      String text,
      Offset offset}) {
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
        textAlign: textAlign ?? TextAlign.center,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontSize: 14))
      ..pushStyle(textStyle ?? ui.TextStyle(color: Colors.black))
      ..addText(text);

    ParagraphConstraints pc = ParagraphConstraints(width: d.width);
    Paragraph paragraph = pb.build()..layout(pc);

    canvas.drawParagraph(paragraph, offset ?? Offset(0.0, 0.0));
  }

  /// 目前只支持修改颜色
  void rect(Descriptor d, {Color color}) {
    Paint _paint = new Paint()
      ..color = color ?? Colors.white
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTWH(d.x, d.y, d.width, d.height), _paint);
  }

  Descriptor get defaultDescriptor => Descriptor(0, 0, size.width, size.height);
}
