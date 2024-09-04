import 'package:flutter/foundation.dart';
import 'package:flutter_element_ui/global.dart';

import '../styles/config.dart';
import '../styles/theme.dart';

/// Element UI 提供的主题服务就是全局变量，直接修改 el.theme、el.darkTheme、el.config
/// 即可应用全局主题，它不依赖 [InheritedWidget] 小部件，对于颜色主题，请通过 context.elTheme
/// 访问自适应颜色变量。
mixin ElThemeService {
  /// Element UI 颜色主题类型集合，因为枚举有点繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// Element UI 全局亮色主题配置，如果需要自适应，请使用 context.elTheme
  ElThemeData theme = ElThemeData();

  /// Element UI 全局暗色主题配置，如果需要自适应，请使用 context.elTheme
  ElThemeData darkTheme = ElThemeData.dark();

  /// Element UI 全局配置
  ElConfigData config = ElConfigData.data;

  /// Element UI 全局断点，它涵盖 320px -> 2560px 范围设备的断点，
  /// 你可以使用它，但不允许自定义，因为会破坏很多组件的响应式逻辑。
  ResponsiveData get responsive => GlobalConfig.responsive;

  /// 通过此方法改变主题这样可以令应用中所有动画小部件的过渡动画保持一致，
  /// 因为切换主题前它会应用全局过渡时间和全局过渡动画曲线。
  /// * fun 实现切换主题的回调函数
  /// * delay 重置动画最小延迟时间，默认500毫秒
  void changeTheme(VoidCallback fun, [int? delay]) =>
      GlobalThemeStyle.changeTheme(fun, delay);
}
