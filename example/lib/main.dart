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
          appBar: AppBar(
            title: Text("MyApp"),
          ),
          body: Container(
            height: 400.0,
            padding: EdgeInsets.only(top: 20.0),
            width: double.infinity,
            child: dp.DayPicker(
              minDateTime: DateTime.now(),
              maxDateTime: DateTime.parse("2020-12-01"),
              headerHeight: 32.0,
            ),
          )),
    );
  }
}
