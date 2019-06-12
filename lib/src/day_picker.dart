import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/view/month_view.dart';

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
        initialPage: _getMonthIndex(
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
    Widget extend = Container(
      height: 40.0,
      width: double.infinity,
      child: Center(
        child: Text("头部"),
      ),
    );

    Widget header = Container(
        height: widget.headerHeight,
        width: double.infinity,
        child: MonthView.generateHeaderView());

    Widget content = Expanded(
      child: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return MonthView.generatePageView(
              _decodeByMonthIndex(widget.minDateTime, index));
        },
        itemCount: _getMonthIndex(widget.minDateTime, widget.maxDateTime) + 1,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
      ),
    );
    return Column(
      children: <Widget>[extend, header, content],
    );
  }

  int _getMonthIndex(DateTime start, DateTime end) {
    return (end.year * 12 + end.month) - (start.year * 12 + start.month);
  }

  DateTime _decodeByMonthIndex(DateTime start, int index) {
    int _yearPlus = (index + 1) ~/ 12;
    int _monthPlus = (index) % 12;

    return DateTime(_yearPlus + start.year, _monthPlus + start.month);
  }
}
