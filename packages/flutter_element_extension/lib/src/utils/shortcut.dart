import 'package:flutter/services.dart';

import 'platform/platform.dart';

class ElShortcutUtil {
  ElShortcutUtil._();

  /// 定义 ctrl 修饰键，但在 Mac 操作系统上，ctrl 修饰键相当于 command 键
  static final ctrl = !PlatformUtil.isMacOS
      ? LogicalKeyboardKey.control
      : LogicalKeyboardKey.meta;
}
