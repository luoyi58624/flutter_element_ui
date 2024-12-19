part of 'index.dart';

/// 全局主题对象，所有组件的全局配置直接通过代码生成器一键生成，避免手动配置。
///
/// 在配置组件的主题前，你要记住以下两点：
/// * 组件自身的配置永远是最高优先级、其次是局部主题、最后才是全局主题：component_theme -> local_theme -> global_theme
/// * 所有主题都强制继承祖先样式，局部主题小部件永远会访问祖先样式然后合并新的主题；
@ElGlobalThemeModel()
class _ElThemeData {
  /// 主要颜色
  final Color primary;

  /// 成功颜色
  final Color success;

  /// 普通颜色
  final Color info;

  /// 警告颜色
  final Color warning;

  /// 错误颜色
  final Color error;

  /// 全局背景色
  final Color bgColor;

  /// 导航栏背景颜色
  final Color navbarColor;

  /// 侧边栏背景颜色
  final Color sidebarColor;

  /// 底部区域栏背景颜色
  final Color footerColor;

  /// 边框颜色
  final Color borderColor;

  /// 模态背景色
  Color modalColor(BuildContext context) =>
      context.currentBgColor.deepen(context.isDark ? 5 : 2);

  /// 边框颜色与背景色进行混合形成的颜色
  Color get borderLightColor => borderColor.mix(bgColor, 50);

  const _ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xfffafafa),
    this.navbarColor = const Color(0xffffffff),
    this.sidebarColor = const Color(0xffffffff),
    this.footerColor = const Color(0xffffffff),
    this.borderColor = const Color(0xffDCDFE6),
  });

  const _ElThemeData.dark({
    this.primary = Colors.white,
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xff2b2b2b),
    this.navbarColor = const Color(0xff404040),
    this.sidebarColor = const Color.fromRGBO(43, 45, 48, 1.0),
    this.footerColor = const Color.fromRGBO(43, 43, 43, 1.0),
    this.borderColor = const Color(0xffa3a3a3),
  });
}
