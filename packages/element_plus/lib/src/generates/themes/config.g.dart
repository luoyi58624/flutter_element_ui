// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigThemeDataExtension on ElConfigThemeData {
  /// 接收一组可选参数，返回新的对象
  ElConfigThemeData copyWith({
    double? size,
    BorderRadius? radius,
    double? borderSize,
    Duration? themeDuration,
    Curve? themeCurve,
  }) {
    return ElConfigThemeData(
      size: size ?? this.size,
      radius: radius ?? this.radius,
      borderSize: borderSize ?? this.borderSize,
      themeDuration: themeDuration ?? this.themeDuration,
      themeCurve: themeCurve ?? this.themeCurve,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElConfigThemeData merge([ElConfigThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      radius: other.radius,
      borderSize: other.borderSize,
      themeDuration: other.themeDuration,
      themeCurve: other.themeCurve,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElConfigTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElConfigTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElConfigThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElConfigThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElConfigTheme>()?.data;

  static ElConfigThemeData of(BuildContext context) {
    final ElConfigTheme? result =
        context.dependOnInheritedWidgetOfExactType<ElConfigTheme>();
    assert(result != null, 'No ElConfigTheme found in context');
    return result!.data;
  }

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElConfigThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElConfigTheme.of(context);
      return ElConfigTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElConfigTheme oldWidget) => true;
}

extension ElConfigThemeDataLerpExtension on ElConfigThemeData {
  ElConfigThemeData lerp(ElConfigThemeData a, ElConfigThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElConfigThemeData(
      size: lerpDouble(a.size, b.size, t) ?? a.size,
      radius: BorderRadius.lerp(a.radius, b.radius, t) ?? a.radius,
      borderSize: lerpDouble(a.borderSize, b.borderSize, t) ?? a.borderSize,
      themeDuration: t < 0.5 ? a.themeDuration : b.themeDuration,
      themeCurve: t < 0.5 ? a.themeCurve : b.themeCurve,
    );
  }
}
