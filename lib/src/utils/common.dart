import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElUtils {
  ElUtils._();

  /// loading 加载光标
  static MouseCursor get loadingCursor {
    if (kIsWeb) return SystemMouseCursors.wait;
    if (PlatformUtil.isMacOS) {
      return SystemMouseCursors.forbidden;
    } else {
      return SystemMouseCursors.wait;
    }
  }
}
