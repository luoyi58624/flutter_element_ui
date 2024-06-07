// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../components/basic/icon.dart';

// **************************************************************************
// ElComponentGenerator
// **************************************************************************

ElIconStyle _style(BuildContext context, ElIconStyle? style) =>
    context.elConfig.iconStyle.merge(
      ElIconTheme._merge(context, style),
    );

class ElIconTheme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ElIconTheme({super.key, required super.child, required this.style});

  final ElIconStyle style;

  static ElIconStyle? _merge(BuildContext context, ElIconStyle? style) {
    var defaultStyle =
        context.dependOnInheritedWidgetOfExactType<ElIconTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElIconTheme oldWidget) => oldWidget.style != style;
}
