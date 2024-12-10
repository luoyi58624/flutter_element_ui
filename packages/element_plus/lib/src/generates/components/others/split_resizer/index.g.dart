// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/split_resizer/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSplitResizerThemeDataExtension on ElSplitResizerThemeData {
  /// 接收一组可选参数，返回新的对象
  ElSplitResizerThemeData copyWith({
    Axis? axis,
    double? size,
    double? triggerSize,
    Color? color,
    Color? activeColor,
    ElSplitPosition? position,
  }) {
    return ElSplitResizerThemeData(
      axis: axis ?? this.axis,
      size: size ?? this.size,
      triggerSize: triggerSize ?? this.triggerSize,
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      position: position ?? this.position,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElSplitResizerThemeData merge([ElSplitResizerThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      axis: other.axis,
      size: other.size,
      triggerSize: other.triggerSize,
      color: other.color,
      activeColor: other.activeColor,
      position: other.position,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElSplitResizerThemeData &&
          runtimeType == other.runtimeType &&
          axis == other.axis &&
          size == other.size &&
          triggerSize == other.triggerSize &&
          color == other.color &&
          activeColor == other.activeColor &&
          position == other.position;

  /// 生成 hashCode 方法
  int get _hashCode =>
      axis.hashCode ^
      size.hashCode ^
      triggerSize.hashCode ^
      color.hashCode ^
      activeColor.hashCode ^
      position.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElSplitResizerTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElSplitResizerTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElSplitResizerThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSplitResizerThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElSplitResizerTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSplitResizerThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.splitResizerTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElSplitResizerTheme.of(context);
    return _ElSplitResizerTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElSplitResizerTheme extends InheritedWidget {
  const _ElSplitResizerTheme({
    required super.child,
    required this.data,
  });

  final ElSplitResizerThemeData data;

  @override
  bool updateShouldNotify(_ElSplitResizerTheme oldWidget) =>
      data != oldWidget.data;
}
