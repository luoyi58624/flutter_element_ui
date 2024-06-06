// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../components/basic/button.dart';

// **************************************************************************
// ElComponentGenerator
// **************************************************************************

ElButtonStyle _style(BuildContext context, ElButtonStyle? style) =>
    ElButtonImportantTheme._merge(
      context,
      context.elConfig.buttonStyle.merge(
        ElButtonTheme._merge(context, style),
      ),
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

class ElButtonImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
  const ElButtonImportantTheme(
      {super.key, required super.child, required this.style});

  final ElButtonStyle style;

  static ElButtonStyle _merge(BuildContext context, ElButtonStyle style) =>
      style.merge(context
          .dependOnInheritedWidgetOfExactType<ElButtonImportantTheme>()
          ?.style);

  @override
  bool updateShouldNotify(ElButtonImportantTheme oldWidget) =>
      oldWidget.style != style;
}
