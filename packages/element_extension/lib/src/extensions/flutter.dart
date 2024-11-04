import 'dart:ui';

import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

/// 这些扩展不会在 element_plus 包中导出，如果你有需要，请自行封装它们
extension FlutterContextExtension on BuildContext {
  /// 获取当平台亮度模式
  Brightness get brightness => ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness.isDark;

  /// Element UI 亮色主题
  ElThemeData get lightTheme => ElApp.of(this).theme;

  /// Element UI 暗色主题
  ElThemeData get darkTheme => ElApp.of(this).darkTheme;

  /// 访问当前文本颜色
  Color? get currentColor => ElCurrentColor.maybeOf(this)?.color;

  /// 访问当前背景颜色
  Color? get currentBgColor => ElCurrentColor.maybeOf(this)?.bgColor;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
        El.primary: elTheme.primary,
        El.success: elTheme.success,
        El.info: elTheme.info,
        El.warning: elTheme.warning,
        El.error: elTheme.error,
      };

  /// 从上下文 context 获取当前 Widget 的坐标位置，默认情况下获取的位置相对于屏幕原点，
  /// 你还可以传递另一个 Widget 的 context 作为参数，计算相对坐标
  Offset getPosition([BuildContext? context]) {
    late Offset offset;
    final renderBox = findRenderObject() as RenderBox;
    offset = renderBox.localToGlobal(Offset.zero);
    if (context != null) {
      final parentRenderBox = context.findRenderObject() as RenderBox;
      final parentOffset = parentRenderBox.localToGlobal(Offset.zero);
      offset = Offset(offset.dx - parentOffset.dx, offset.dy - parentOffset.dy);
    }
    return offset;
  }
}

extension FlutterBorderExtension on Border {
  /// 获取 Border 最大的宽度
  double get maxWidth {
    final list = [left.width, left.width, left.width, left.width];
    list.sort();
    return list.last;
  }
}

extension FlutterBrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
}
