import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

mixin LoggerService {
  /// 设置日志打印级别，默认情况下，在开发环境会展示所有基本日志，生产环境则屏蔽所有日志
  void setLogger({Level? level, Logger? logger}) {
    _loggerInstance = logger ??
        Logger(
          printer: _prettyPrinter,
          filter: _LoggerFilter(loggerLevel: level),
        );
  }

  /// debug 级别日志输出
  void d(dynamic message, [dynamic title]) {
    _loggerInstance.d(message, error: title);
  }

  /// info 级别日志输出
  void i(dynamic message, [dynamic title]) {
    _loggerInstance.i(message, error: title);
  }

  /// warning 级别日志输出
  void w(dynamic message, [dynamic title]) {
    _loggerInstance.w(message, error: title);
  }

  /// error 级别日志输出
  void e(dynamic message, [dynamic title]) {
    _loggerInstance.e(message, error: title);
  }
}

PrettyPrinter _prettyPrinter = PrettyPrinter(
  methodCount: 2,
  errorMethodCount: 2,
  printEmojis: false,
  noBoxingByDefault: false,
);

var _loggerInstance = Logger(
  printer: _prettyPrinter,
  filter: _LoggerFilter(loggerLevel: null),
);

class _LoggerFilter extends LogFilter {
  final Level? loggerLevel;

  _LoggerFilter({this.loggerLevel});

  @override
  bool shouldLog(LogEvent event) {
    if (loggerLevel == null) {
      return kDebugMode;
    } else {
      return event.level.value >= loggerLevel!.value;
    }
  }
}
