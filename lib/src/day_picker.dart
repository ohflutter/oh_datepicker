import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/core/view.dart';
import 'package:oh_datepicker/src/extend/slider_header.dart';
import 'package:oh_datepicker/src/utils.dart';

class DayPicker extends StatefulWidget {
  DayPicker(
      {Key key,
      @required this.minDateTime,
      @required this.maxDateTime,
      this.initialDateTime,
      this.headerHeight: 40.0})
      : super(key: key) {
    assert(minDateTime.compareTo(maxDateTime) <= 0);
    if (initialDateTime != null)
      assert(initialDateTime.compareTo(minDateTime) >= 0 &&
          initialDateTime.compareTo(maxDateTime) <= 0);
  }

  final DateTime minDateTime, maxDateTime, initialDateTime;
  final double headerHeight;
  @override
  _DayPickerState createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: getMonthIndex(
      widget.minDateTime,
      widget.initialDateTime ?? DateTime.now(),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SliderHeader sliderHeader = new SliderHeader(
        maxDateTime: widget.maxDateTime,
        minDateTime: widget.minDateTime,
        initialDateTime: widget.initialDateTime);

    Widget sliderHeaderWidget = sliderHeader.build(context);

    Widget header = Container(
        height: widget.headerHeight,
        width: double.infinity,
        child: View.header());

    Widget content = Expanded(
      child: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return View.month(decodeByMonthIndex(widget.minDateTime, index));
        },
        itemCount: getMonthIndex(widget.minDateTime, widget.maxDateTime) + 1,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          sliderHeader.scrollTo(decodeByMonthIndex(widget.minDateTime, index));
        },
      ),
    );
    return Column(
      children: <Widget>[sliderHeaderWidget, header, content],
    );
  }
}
