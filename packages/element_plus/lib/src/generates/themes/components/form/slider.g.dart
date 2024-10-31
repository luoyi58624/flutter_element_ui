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

class ElSliderTheme extends StatelessWidget {
  const ElSliderTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElSliderThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSliderThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElSliderTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElSliderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.sliderTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElSliderTheme.of(context);
    return _ElSliderTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElSliderTheme extends InheritedWidget {
  const _ElSliderTheme({
    required super.child,
    required this.data,
  });

  final ElSliderThemeData data;

  @override
  bool updateShouldNotify(_ElSliderTheme oldWidget) => true;
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
