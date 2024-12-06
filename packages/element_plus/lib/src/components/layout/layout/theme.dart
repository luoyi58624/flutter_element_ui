part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '布局样式')
class ElLayoutThemeData {
  static const theme = ElLayoutThemeData(
    bgColor: Color(0xfffafafa),
    navbarColor: Color(0xffffffff),
    sidebarColor: Color(0xffffffff),
    footerColor: Color(0xffffffff),
    borderColor: Color(0xffDCDFE6),
  );

  static const darkTheme = ElLayoutThemeData(
    bgColor: Color(0xff2b2b2b),
    navbarColor: Color(0xff404040),
    sidebarColor: Color.fromRGBO(43, 45, 48, 1.0),
    footerColor: Color.fromRGBO(43, 43, 43, 1.0),
    borderColor: Color(0xffa3a3a3),
  );

  const ElLayoutThemeData({
    this.bgColor,
    this.borderColor,
    this.navbarColor,
    this.sidebarColor,
    this.footerColor,
  });

  /// 全局背景色
  final Color? bgColor;

  /// 导航栏背景颜色
  final Color? navbarColor;

  /// 侧边栏背景颜色
  final Color? sidebarColor;

  /// 底部区域栏背景颜色
  final Color? footerColor;

  /// 边框颜色
  final Color? borderColor;

  /// 边框颜色与背景色进行混合形成的颜色
  Color get borderLightColor => borderColor!.mix(bgColor!, 50);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
