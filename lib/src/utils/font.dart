import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../app.dart';

class ElFont {
  ElFont._();

  /// 普通字重
  static FontWeight get normal => FontUtil.normal;

  static set normal(FontWeight v) => FontUtil.normal = v;

  /// 中等字重
  static FontWeight get medium => FontUtil.medium;

  static set medium(FontWeight v) => FontUtil.medium = v;

  /// 粗体字重
  static FontWeight get bold => FontUtil.bold;

  static set bold(FontWeight v) => FontUtil.bold = v;

  /// [ElApp] 应用的默认文本样式，默认样式仅适用于中文，你可以在构建 [ElApp] 之前自定义它，
  /// 也可以通过 [ElApp] textStyle 参数覆盖它
  static TextStyle defaultTextStyle = TextStyle(
    fontFamily: null,
    fontFamilyFallback: (PlatformUtil.isMacOS || PlatformUtil.isIOS)
        ? ['.AppleSystemUIFont', 'PingFang SC']
        : PlatformUtil.isWindows
            ? ['Microsoft YaHei', '微软雅黑']
            : null,
  );
}
