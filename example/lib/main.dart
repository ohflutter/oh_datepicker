import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oh_datepicker/oh_datepicker.dart' as dp;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Center(
        child: Container(
          height: 400.0,
          width: double.infinity,
          child: dp.DayPicker(
            minDateTime: DateTime.parse("2019-06-01"),
            maxDateTime: DateTime.parse("2020-12-01"),
            initialDateTime: DateTime.parse("2019-06-01"),
            headerHeight: 48.0,
          ),
        ),
      )),
    );
  }
}
