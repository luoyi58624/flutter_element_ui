// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/tag.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTagThemeDataExtension on ElTagThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTagThemeData copyWith({
    double? size,
  }) {
    return ElTagThemeData(
      size: size ?? this.size,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTagThemeData merge([ElTagThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTagTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElTagTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTagThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTagThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTagTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTagThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.tagTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTagThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTagTheme.of(context);
      return ElTagTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTagTheme oldWidget) => true;
}

extension ElTagThemeDataLerpExtension on ElTagThemeData {
  /// 主题动画线性插值
  ElTagThemeData lerp(ElTagThemeData a, ElTagThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTagThemeData(
      size: lerpDouble(a.size, b.size, t) ?? a.size,
    );
  }
}
