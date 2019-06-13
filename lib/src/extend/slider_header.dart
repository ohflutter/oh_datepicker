import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/utils.dart';

class SliderHeader {
  final DateTime minDateTime, maxDateTime, initialDateTime;
  SliderHeader(
      {Key key,
      @required this.minDateTime,
      @required this.maxDateTime,
      @required this.initialDateTime});
  CarouselSlider _yearSlider, _monthSlider;

  Widget build(BuildContext context) {
    int yearCount = (getMonthIndex(minDateTime, maxDateTime) + 1) ~/ 12 + 1;

    List<String> years = List.generate(yearCount, (index) {
      return (minDateTime.year + index).toString() + "年";
    }).toList();

    List<String> months = List.generate(12, (index) {
      return (index + 1).toString() + "月";
    }).toList();

    _yearSlider = CarouselSlider(
      height: 32.0,
      viewportFraction: 1.0,
      autoPlay: false,
      scrollDirection: Axis.vertical,
      initialPage: initialDateTime.year - minDateTime.year,
      enableInfiniteScroll: false,
      items: years.map((text) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
            );
          },
        );
      }).toList(),
    );

    _monthSlider = CarouselSlider(
      height: 32.0,
      viewportFraction: 1.0,
      autoPlay: false,
      scrollDirection: Axis.vertical,
      initialPage: initialDateTime.month - 1,
      enableInfiniteScroll: false,
      items: months.map((text) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
            );
          },
        );
      }).toList(),
    );

    return Container(
      height: 16.0,
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(height: 16.0, width: 64.0, child: _yearSlider),
          Container(height: 16.0, width: 48.0, child: _monthSlider)
        ],
      ),
    );
  }

  void scrollTo(DateTime time) {
    _yearSlider.animateToPage(time.year - minDateTime.year,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);

    _monthSlider.animateToPage(time.month - 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
