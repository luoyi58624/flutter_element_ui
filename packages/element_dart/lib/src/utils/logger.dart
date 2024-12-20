import 'package:logger/logger.dart';

import 'common.dart';

/// 全局日志打印对象，默认情况下，在开发环境会打印所有级别日志，生产环境则打印警告级别以上日志
Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 2,
    printEmojis: false,
    noBoxingByDefault: false,
  ),
  filter: _LoggerFilter(loggerLevel: isRelease ? Level.warning : Level.all),
);

/// debug 级别日志输出
void d(dynamic message, [dynamic title]) {
  logger.d(message, error: title);
}

/// info 级别日志输出
void i(dynamic message, [dynamic title]) {
  logger.i(message, error: title);
}

/// warning 级别日志输出
void w(dynamic message, [dynamic title]) {
  logger.w(message, error: title);
}

/// error 级别日志输出
void e(dynamic message, [dynamic title]) {
  logger.e(message, error: title);
}

class _LoggerFilter extends LogFilter {
  final Level loggerLevel;

  _LoggerFilter({required this.loggerLevel});

  @override
  bool shouldLog(LogEvent event) {
    return event.level.value >= loggerLevel.value;
  }
}
