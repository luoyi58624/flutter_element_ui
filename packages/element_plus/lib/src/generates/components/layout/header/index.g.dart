// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/layout/header/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElHeaderThemeDataExtension on ElHeaderThemeData {
  /// 接收一组可选参数，返回新的对象
  ElHeaderThemeData copyWith({
    Color? color,
    double? height,
  }) {
    return ElHeaderThemeData(
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElHeaderThemeData merge([ElHeaderThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      height: other.height,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElHeaderTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElHeaderTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElHeaderThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElHeaderThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElHeaderTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElHeaderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.headerTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElHeaderTheme.of(context);
    return _ElHeaderTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElHeaderTheme extends InheritedWidget {
  const _ElHeaderTheme({
    required super.child,
    required this.data,
  });

  final ElHeaderThemeData data;

  @override
  bool updateShouldNotify(_ElHeaderTheme oldWidget) => true;
}
