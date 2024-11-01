// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/collapse.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCollapseThemeDataExtension on ElCollapseThemeData {
  /// 接收一组可选参数，返回新的对象
  ElCollapseThemeData copyWith({
    bool? keepState,
    Duration? duration,
    Curve? curve,
  }) {
    return ElCollapseThemeData(
      keepState: keepState ?? this.keepState,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElCollapseThemeData merge([ElCollapseThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      keepState: other.keepState,
      duration: other.duration,
      curve: other.curve,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElCollapseTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElCollapseTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElCollapseThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCollapseThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElCollapseTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCollapseThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.collapseTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElCollapseTheme.of(context);
    return _ElCollapseTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElCollapseTheme extends InheritedWidget {
  const _ElCollapseTheme({
    required super.child,
    required this.data,
  });

  final ElCollapseThemeData data;

  @override
  bool updateShouldNotify(_ElCollapseTheme oldWidget) => true;
}
