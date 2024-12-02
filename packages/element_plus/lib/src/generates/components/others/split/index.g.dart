// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/split/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSplitThemeDataExtension on ElSplitThemeData {
  /// 接收一组可选参数，返回新的对象
  ElSplitThemeData copyWith({
    double? size,
    double? triggerSize,
    Color? color,
    Color? activeColor,
    ElSplitPosition? position,
  }) {
    return ElSplitThemeData(
      size: size ?? this.size,
      triggerSize: triggerSize ?? this.triggerSize,
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      position: position ?? this.position,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElSplitThemeData merge([ElSplitThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      triggerSize: other.triggerSize,
      color: other.color,
      activeColor: other.activeColor,
      position: other.position,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElSplitTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElSplitTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElSplitThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSplitThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElSplitTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSplitThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.splitTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElSplitTheme.of(context);
    return _ElSplitTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElSplitTheme extends InheritedWidget {
  const _ElSplitTheme({
    required super.child,
    required this.data,
  });

  final ElSplitThemeData data;

  @override
  bool updateShouldNotify(_ElSplitTheme oldWidget) => true;
}
