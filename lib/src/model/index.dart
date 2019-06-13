import 'package:oh_datepicker/src/utils.dart';

class Model {
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
  static List<List<DateTime>> month(DateTime day) {
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

  /// 日历头部
  ///
  static List<String> header() {
    return ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
  }
}
