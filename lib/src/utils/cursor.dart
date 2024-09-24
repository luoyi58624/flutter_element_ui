import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElCursorUtil {
  ElCursorUtil._();

  /// loading 加载光标
  static MouseCursor get loadingCursor {
    if (kIsWeb) return SystemMouseCursors.wait;
    if (PlatformUtil.isMacOS) {
      return SystemMouseCursors.forbidden;
    } else {
      return SystemMouseCursors.wait;
    }
  }

  /// 构建抓握样式，手指张开
  static MouseCursor get grab {
    if (kIsWeb) return SystemMouseCursors.grab;
    if (PlatformUtil.isWindows) {
      return SystemMouseCursors.click;
    } else {
      return SystemMouseCursors.grab;
    }
  }

  /// 构建抓握样式，手指闭合
  static MouseCursor get grabbing {
    if (kIsWeb) return SystemMouseCursors.grabbing;
    if (PlatformUtil.isWindows) {
      return SystemMouseCursors.click;
    } else {
      return SystemMouseCursors.grabbing;
    }
  }
}
