part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '滑块默认样式')
class ElSliderThemeData {
  static const theme = ElSliderThemeData(
    inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
  );
  static const darkTheme = ElSliderThemeData(
    inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
  );

  const ElSliderThemeData({
    this.sliderSize = 18,
    this.thumbSize = 4,
    this.activeColor,
    required this.inactiveColor,
  });

  /// 滑块整体尺寸
  final double sliderSize;

  /// 滑块轨道尺寸
  final double thumbSize;

  /// 滑块激活颜色，如果为 null，则跟随 primary 主题色
  final Color? activeColor;

  /// 滑块未激活颜色
  final Color inactiveColor;
}

