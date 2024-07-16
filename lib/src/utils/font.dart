import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

/// Element UI 字重，之所以不直接使用 [FontWeight] 是因为有时候希望能更改全局字重，
/// 例如 normal -> w500，bold -> w600 等等
class ElFont {
  ElFont._();

  static FontWeight normal = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight bold = FontWeight.w700;

  /// 字体回退列表，flutter会根据此列表依次匹配字体
  static List<String>? get fontFamilyFallback {
    // 在 mac 上若不指定苹方字体，那么中文字重只有两种
    if (PlatformUtil.isMacOS || PlatformUtil.isIOS) {
      return ['.AppleSystemUIFont', 'PingFang SC'];
    } else if (PlatformUtil.isWindows) {
      return ['Microsoft YaHei', '微软雅黑'];
    } else {
      return null;
    }
  }
}
