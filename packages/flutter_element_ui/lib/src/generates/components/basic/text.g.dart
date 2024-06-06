// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../components/basic/text.dart';

// **************************************************************************
// ElComponentGenerator
// **************************************************************************

ElTextStyle _style(BuildContext context, ElTextStyle? style) =>
    ElTextImportantTheme._merge(
      context,
      context.elConfig.textStyle.merge(
        ElTextTheme._merge(context, style),
      ),
    );

class ElTextTheme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ElTextTheme({super.key, required super.child, required this.style});

  final ElTextStyle style;

  static ElTextStyle? _merge(BuildContext context, ElTextStyle? style) {
    var defaultStyle =
        context.dependOnInheritedWidgetOfExactType<ElTextTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElTextTheme oldWidget) => oldWidget.style != style;
}

class ElTextImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
  const ElTextImportantTheme(
      {super.key, required super.child, required this.style});

  final ElTextStyle style;

  static ElTextStyle _merge(BuildContext context, ElTextStyle style) =>
      style.merge(context
          .dependOnInheritedWidgetOfExactType<ElTextImportantTheme>()
          ?.style);

  @override
  bool updateShouldNotify(ElTextImportantTheme oldWidget) =>
      oldWidget.style != style;
}
