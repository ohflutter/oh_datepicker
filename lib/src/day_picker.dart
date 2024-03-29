import 'package:flutter/material.dart';
import 'package:oh_datepicker/src/core/view.dart';
import 'package:oh_datepicker/src/extend/magic_view.dart';
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
  final GlobalKey<MagicViewState> yareKey = GlobalKey();
  final GlobalKey<MagicViewState> monthKey = GlobalKey();

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
    Widget header = Container(
        height: widget.headerHeight,
        width: double.infinity,
        child: View.header());

    Widget content = Expanded(
        child: PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return View.month(decodeByMonthIndex(widget.minDateTime, index), context);
      },
      itemCount: getMonthIndex(widget.minDateTime, widget.maxDateTime) + 1,
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        DateTime nextDateTime = decodeByMonthIndex(widget.minDateTime, index);

        yareKey.currentState.next(nextDateTime.year.toString() + "年");
        monthKey.currentState.next(nextDateTime.month.toString() + "月");
      },
    ));
    return Column(
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new MagicView(
                key: yareKey,
                height: 42.0,
                width: 64.0,
                initialValue: widget.initialDateTime.year.toString() + "年",
              ),
              new MagicView(
                key: monthKey,
                height: 42.0,
                width: 40.0,
                initialValue: widget.initialDateTime.month.toString() + "月",
              )
            ],
          ),
        ),
        header,
        content
      ],
    );
  }
}
