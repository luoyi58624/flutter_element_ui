extension DartIntExtension on int {
  /// 返回时间对象: 毫秒
  Duration get ms => Duration(milliseconds: this);

  /// 返回时间对象: 秒
  Duration get ss => Duration(seconds: this);

  /// 返回时间对象: 分钟
  Duration get mm => Duration(minutes: this);

  /// 返回时间对象: 小时
  Duration get hh => Duration(hours: this);

  /// 返回时间对象: 天
  Duration get dd => Duration(days: this);
}
