import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ElFont {
  ElFont._();

  /// 普通字重
  static FontWeight normal = FontWeight.w400;

  /// 中等字重
  static FontWeight medium = FontWeight.w500;

  /// 粗体字重
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
