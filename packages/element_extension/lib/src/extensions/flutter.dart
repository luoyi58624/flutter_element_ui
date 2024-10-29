import 'dart:ui';

import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

import '../widgets/scroll_behavior.dart';

extension FlutterContextExtension on BuildContext {
  /// 获取当平台亮度模式
  Brightness? get brightness => ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness == Brightness.dark;

  /// Element UI 亮色主题
  ElThemeData get lightTheme => ElApp.of(this).theme;

  /// Element UI 暗色主题
  ElThemeData get darkTheme => ElApp.of(this).darkTheme;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
    'primary': elTheme.primary,
    'success': elTheme.success,
    'info': elTheme.info,
    'warning': elTheme.warning,
    'error': elTheme.error,
  };

  /// 从上下文 context 获取当前 Widget 的坐标位置，默认情况下获取的位置相对于屏幕原点，
  /// 你还可以传递另一个 Widget 的 context 作为参数，计算相对坐标
  Offset getOffset([BuildContext? context]) {
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

extension FlutterWidgetExtension on Widget {
  /// 不使用祖先提供的默认滚动条
  Widget get noScrollBehavior => ScrollConfiguration(
        behavior: const NoScrollBehavior(),
        child: this,
      );

  /// 将 [RawScrollbar] 作为默认滚动条
  Widget get rawScrollBehavior => ScrollConfiguration(
        behavior: const RawScrollBehavior(),
        child: this,
      );

  /// 将 [Scrollbar] 作为默认滚动条
  Widget get materialScrollBehavior => ScrollConfiguration(
        behavior: const MaterialScrollBehavior(),
        child: this,
      );

  /// 使用 [CupertinoScrollbar] 作为默认滚动条
  Widget get cupertinoScrollBehavior => ScrollConfiguration(
        behavior: const CupertinoScrollBehavior(),
        child: this,
      );
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
