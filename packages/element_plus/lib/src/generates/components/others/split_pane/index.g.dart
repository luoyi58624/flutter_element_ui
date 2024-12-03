// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/split_pane/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSplitPaneThemeDataExtension on ElSplitPaneThemeData {
  /// 接收一组可选参数，返回新的对象
  ElSplitPaneThemeData copyWith({
    Axis? axis,
  }) {
    return ElSplitPaneThemeData(
      axis: axis ?? this.axis,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElSplitPaneThemeData merge([ElSplitPaneThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      axis: other.axis,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElSplitPaneThemeData &&
          runtimeType == other.runtimeType &&
          axis == other.axis;

  /// 生成 hashCode 方法
  int get _hashCode => axis.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElSplitPaneTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElSplitPaneTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElSplitPaneThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSplitPaneThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElSplitPaneTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSplitPaneThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.splitPaneTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElSplitPaneTheme.of(context);
    return _ElSplitPaneTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElSplitPaneTheme extends InheritedWidget {
  const _ElSplitPaneTheme({
    required super.child,
    required this.data,
  });

  final ElSplitPaneThemeData data;

  @override
  bool updateShouldNotify(_ElSplitPaneTheme oldWidget) =>
      data != oldWidget.data;
}
