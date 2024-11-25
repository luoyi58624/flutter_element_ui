// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/tree/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTreeThemeDataExtension on ElTreeThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTreeThemeData copyWith({
    double? itemHeight,
    double? iconSize,
    double? parentGap,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return ElTreeThemeData(
      itemHeight: itemHeight ?? this.itemHeight,
      iconSize: iconSize ?? this.iconSize,
      parentGap: parentGap ?? this.parentGap,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTreeThemeData merge([ElTreeThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      itemHeight: other.itemHeight,
      iconSize: other.iconSize,
      parentGap: other.parentGap,
      padding: other.padding,
      borderRadius: other.borderRadius,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTreeTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElTreeTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElTreeThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTreeThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTreeTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTreeThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.treeTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElTreeTheme.of(context);
    return _ElTreeTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElTreeTheme extends InheritedWidget {
  const _ElTreeTheme({
    required super.child,
    required this.data,
  });

  final ElTreeThemeData data;

  @override
  bool updateShouldNotify(_ElTreeTheme oldWidget) => true;
}
