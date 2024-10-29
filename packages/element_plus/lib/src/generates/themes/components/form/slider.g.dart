// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/form/slider.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSliderThemeDataExtension on ElSliderThemeData {
  /// 接收一组可选参数，返回新的对象
  ElSliderThemeData copyWith({
    double? sliderSize,
    double? thumbSize,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return ElSliderThemeData(
      sliderSize: sliderSize ?? this.sliderSize,
      thumbSize: thumbSize ?? this.thumbSize,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElSliderThemeData merge([ElSliderThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      sliderSize: other.sliderSize,
      thumbSize: other.thumbSize,
      activeColor: other.activeColor,
      inactiveColor: other.inactiveColor,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElSliderTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElSliderTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElSliderThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSliderThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElSliderTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSliderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.sliderTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElSliderThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElSliderTheme.of(context);
      return ElSliderTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElSliderTheme oldWidget) => true;
}

extension ElSliderThemeDataLerpExtension on ElSliderThemeData {
  /// 主题动画线性插值
  ElSliderThemeData lerp(ElSliderThemeData a, ElSliderThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElSliderThemeData(
      sliderSize: lerpDouble(a.sliderSize, b.sliderSize, t) ?? a.sliderSize,
      thumbSize: lerpDouble(a.thumbSize, b.thumbSize, t) ?? a.thumbSize,
      activeColor: Color.lerp(a.activeColor, b.activeColor, t) ?? a.activeColor,
      inactiveColor:
          Color.lerp(a.inactiveColor, b.inactiveColor, t) ?? a.inactiveColor,
    );
  }
}
