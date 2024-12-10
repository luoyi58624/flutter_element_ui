import 'package:element_plus/src/app/index.dart';
import 'package:flutter/widgets.dart';

extension ElCurrentColorExtension on BuildContext {
  /// 当前文本颜色，默认为全局文本主题颜色
  Color get currentTextColor =>
      ElCurrentColor.maybeOf(this)?.textColor ??
      elTheme.textTheme.textStyle.color!;

  /// 当前背景颜色，默认为全局背景色
  Color get currentBgColor =>
      ElCurrentColor.maybeOf(this)?.bgColor ?? elTheme.layoutTheme.bgColor!;
}

class ElCurrentColor extends InheritedWidget {
  /// 一个功能小部件，传递当前文字颜色、背景颜色，在 Element UI 中，
  /// 所有包含背景颜色的小部件都会注入自身颜色。
  ///
  /// 使用场景：有些 Widget 需要将自身颜色跟随背景色，你可能会考虑不设置颜色或者直接设置透明颜色，
  /// 通常情况下这么做没问题，但如果这个小部件的颜色需要参与交互，那么你就必须指定一个颜色，
  /// 而这个颜色不能是透明，否则动画过程中视觉效果会不统一。
  const ElCurrentColor({
    super.key,
    this.textColor,
    this.bgColor,
    required super.child,
  });

  /// 当前文本颜色
  final Color? textColor;

  /// 当前背景颜色
  final Color? bgColor;

  static ElCurrentColor? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElCurrentColor>();

  @override
  bool updateShouldNotify(ElCurrentColor oldWidget) => true;
}
