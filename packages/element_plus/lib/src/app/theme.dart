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

  const _ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
  });

  const _ElThemeData.dark({
    this.primary = Colors.white,
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
  });
}
