part of 'index.dart';

/// 全局主题对象，所有组件的全局配置直接通过代码生成器一键生成，避免手动配置。
///
/// 提示：生成的很多主题可能包含许多可选符号，如果全局主题包含默认值，那么它们将永远不会为空，
/// 后续合并主题时 null 值会被排除，所以你可以放心使用 ! 移除警告。
///
/// 在配置组件的主题前，你要记住以下两点：
/// * 组件自身的配置永远是最高优先级、其次是局部主题、最后才是全局主题：component_theme -> local_theme -> global_theme
/// * 所有主题都强制继承祖先样式，局部主题小部件永远会访问祖先样式然后合并新的主题；

// 配置局部主题时，想要将主题的某个属性设置为 null 怎么办？
// 很遗憾，你做不到，一旦祖先某个属性设置了值，那么你就不能将其设置为 null，你只能覆盖一个非空的新值，
// 如果支持将某个属性设置为 null，那么后代某个组件添加了 ! 符号就很容易导致程序异常，这只会增加自己的心智负担。
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
