part of 'index.dart';

class ElIconTheme extends InheritedWidget {
  /// 提供默认的图标主题
  const ElIconTheme({
    super.key,
    required super.child,
    this.icon,
    this.size,
    this.color,
  });

  final dynamic icon;
  final double? size;
  final Color? color;

  static ElIconTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElIconTheme>();

  static ElIconTheme of(BuildContext context) => maybeOf(context)!;

  @override
  bool updateShouldNotify(ElIconTheme oldWidget) => oldWidget != this;
}

