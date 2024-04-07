part of flutter_element_ui;

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 2,
    printEmojis: false,
    noBoxingByDefault: false,
  ),
);

/// 打印日志工具类
class _ElLogger {
  ElLogger(dynamic message, [dynamic title]) {
    _logger.i(message, error: title);
  }

  static void d(dynamic message, [dynamic title]) {
    _logger.d(message, error: title);
  }

  static void i(dynamic message, [dynamic title]) {
    _logger.i(message, error: title);
  }

  static void w(dynamic message, [dynamic title]) {
    _logger.w(message, error: title);
  }

  static void e(dynamic message, [dynamic title]) {
    _logger.e(message, error: title);
  }
}
