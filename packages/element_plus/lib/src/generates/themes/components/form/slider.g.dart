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
  /// 设置局部默认数据，注意：如果你想尊重 "全局" 或 "祖先" 提供的默认样式，请使用 [merge] 方法构建
  const ElSliderTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElSliderThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElSliderThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElSliderTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSliderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.sliderTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
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
