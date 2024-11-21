part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '布局样式')
class ElLayoutThemeData {
  static const theme = ElLayoutThemeData(
    bgColor: Color(0xfffafafa),
    navbarColor: Color(0xffffffff),
    sidebarColor: Color(0xffffffff),
    borderColor: Color(0xffDCDFE6),
  );

  static const darkTheme = ElLayoutThemeData(
    bgColor: Color(0xff2b2b2b),
    navbarColor: Color(0xff404040),
    sidebarColor: Color(0xff374151),
    borderColor: Color(0xffa3a3a3),
  );

  const ElLayoutThemeData({
    this.bgColor,
    this.borderColor,
    this.navbarColor,
    this.sidebarColor,
  });

  /// 全局背景色
  final Color? bgColor;

  /// 导航栏背景颜色
  final Color? navbarColor;

  /// 侧边栏背景颜色
  final Color? sidebarColor;

  /// 边框颜色
  final Color? borderColor;

  /// 边框颜色与背景色进行混合形成的颜色
  Color get borderLightColor => borderColor!.mix(bgColor!, 50);
}
