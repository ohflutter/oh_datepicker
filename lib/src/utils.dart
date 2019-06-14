/// 获取本月最后一天
DateTime getLastDayOfMonth(DateTime dateTime) {
  int _year = dateTime.year;
  int _month = dateTime.month;
  return DateTime(_month < 12 ? _year : ++_year, _month == 12 ? 1 : _month + 1)
      .subtract(Duration(days: 1));
}

int getMonthIndex(DateTime start, DateTime end) {
  return (end.year * 12 + end.month) - (start.year * 12 + start.month);
}

DateTime decodeByMonthIndex(DateTime start, int index) {
  int months = start.year * 12 + index + start.month;
  return DateTime((months / 12).floor(), months % 12);
}
