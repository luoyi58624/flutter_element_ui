// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/header.dart';

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

class ElHeaderTheme extends InheritedWidget {
  const ElHeaderTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElHeaderThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElHeaderThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElHeaderTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElHeaderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.headerTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElHeaderThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElHeaderTheme.of(context);
      return ElHeaderTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElHeaderTheme oldWidget) => true;
}
