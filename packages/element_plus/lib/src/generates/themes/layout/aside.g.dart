// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/aside.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElAsideThemeDataExtension on ElAsideThemeData {
  /// 接收一组可选参数，返回新的对象
  ElAsideThemeData copyWith({
    Color? color,
    double? width,
  }) {
    return ElAsideThemeData(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElAsideThemeData merge([ElAsideThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      width: other.width,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElAsideTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElAsideTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElAsideThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElAsideThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElAsideTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElAsideThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.asideTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElAsideThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElAsideTheme.of(context);
      return ElAsideTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElAsideTheme oldWidget) => true;
}
