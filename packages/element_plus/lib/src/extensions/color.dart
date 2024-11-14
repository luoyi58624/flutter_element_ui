import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 注意：颜色扩展函数不支持线性插值，如果你引用这些扩展函数，那么请不要使用 [context.elTheme]
extension ElColorExtension on Color {
  Color elLight1(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 1, reverse);

  Color elLight2(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 2, reverse);

  Color elLight3(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 3, reverse);

  Color elLight4(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 4, reverse);

  Color elLight5(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 5, reverse);

  Color elLight6(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 6, reverse);

  Color elLight7(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 7, reverse);

  Color elLight8(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 8, reverse);

  Color elLight9(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 9, reverse);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) {
    assert(context.lightTheme.textTheme.textStyle.color != null, '亮色文本颜色不能为空');
    assert(context.darkTheme.textTheme.textStyle.color != null, '暗色文本颜色不能为空');

    return isDark
        ? context.darkTheme.textTheme.textStyle.color!
        : context.lightTheme.textTheme.textStyle.color!;
  }

  /// 根据当前颜色生成 Element UI 9 种级别的渐变颜色
  List<Color> elLights(BuildContext context) {
    return [
      elLight1(context),
      elLight2(context),
      elLight3(context),
      elLight4(context),
      elLight5(context),
      elLight6(context),
      elLight7(context),
      elLight8(context),
      elLight9(context),
    ];
  }
}

extension _ColorExtension on Color {
  Color _darken(int level) => mix(const Color(0xff222222), level * 9);

  Color _brighten(int level) => mix(const Color(0xffffffff), level * 10);

  /// 根据当前颜色返回符合 Element 主题系统颜色。
  /// * 如果当前是亮色模式，则与白色进行混合，level 级别越高，颜色越接近白色
  /// * 如果当前是暗色模式，则与黑色进行混合，level 级别越高，颜色越接近黑色
  /// * reverse - 是否应用反转颜色
  Color _elLight(BuildContext context, int level, bool reverse) {
    assert(level >= 1 && level <= 9, 'elLight 颜色级别范围必须是 1 - 9，但却得到: $level');
    if (!reverse) {
      return context.isDark ? _darken(level) : _brighten(level);
    } else {
      return context.isDark ? _brighten(level) : _darken(level);
    }
  }
}
