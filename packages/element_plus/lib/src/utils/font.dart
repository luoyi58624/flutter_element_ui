import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

class ElFont {
  ElFont._();

  /// 普通字重
  static FontWeight normal = FontWeight.w400;

  /// 中等字重
  static FontWeight medium = FontWeight.w500;

  /// 粗体字重
  static FontWeight bold = FontWeight.w600;

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
