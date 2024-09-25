part of '../index.dart';

class _LineProgressInheritedWidget extends InheritedWidget {
  const _LineProgressInheritedWidget(
    this.vertical, {
    required super.child,
  });

  final bool vertical;

  static _LineProgressInheritedWidget of(BuildContext context) {
    final _LineProgressInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_LineProgressInheritedWidget>();
    assert(result != null, 'No _LineProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_LineProgressInheritedWidget oldWidget) => true;
}

/// 默认的直线进度条
class _LineProgress extends StatelessWidget {
  const _LineProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
