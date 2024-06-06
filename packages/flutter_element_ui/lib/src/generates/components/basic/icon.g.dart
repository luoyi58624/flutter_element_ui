// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../components/basic/icon.dart';

// **************************************************************************
// ElComponentGenerator
// **************************************************************************

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

class ElIconImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
  const ElIconImportantTheme(
      {super.key, required super.child, required this.style});

  final ElIconStyle style;

  static ElIconStyle _merge(BuildContext context, ElIconStyle style) =>
      style.merge(context
          .dependOnInheritedWidgetOfExactType<ElIconImportantTheme>()
          ?.style);

  @override
  bool updateShouldNotify(ElIconImportantTheme oldWidget) =>
      oldWidget.style != style;
}
