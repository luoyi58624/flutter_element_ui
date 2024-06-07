// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../components/basic/button.dart';

// **************************************************************************
// ElComponentGenerator
// **************************************************************************

ElButtonStyle _style(BuildContext context, ElButtonStyle? style) =>
    context.elConfig.buttonStyle.merge(
      ElButtonTheme._merge(context, style),
    );

class ElButtonTheme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ElButtonTheme({super.key, required super.child, required this.style});

  final ElButtonStyle style;

  static ElButtonStyle? _merge(BuildContext context, ElButtonStyle? style) {
    var defaultStyle =
        context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => oldWidget.style != style;
}
