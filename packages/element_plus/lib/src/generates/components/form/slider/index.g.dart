// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/form/slider/index.dart';

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
  /// 提供局部默认主题小部件
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

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElSliderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.sliderTheme;

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
