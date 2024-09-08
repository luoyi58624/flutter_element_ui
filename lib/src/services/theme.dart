import 'package:flutter/animation.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../styles/config.dart';
import '../styles/theme.dart';
import '../widgets/global_theme_duration.dart';

mixin ElThemeService {
  /// Element UI 颜色主题类型集合，因为枚举略显繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// Element UI 全局断点，它涵盖 320px -> 2560px 范围设备的断点，
  /// 你可以使用它，但不允许自定义，因为会破坏很多组件的响应式逻辑。
  ResponsiveData get responsive => responsiveData;

  /// 通过此方法改变主题这样可以令应用中所有动画小部件的过渡动画保持一致，
  /// 因为切换主题前它会应用全局过渡时间和全局过渡动画曲线。
  /// * fun 实现切换主题的回调函数
  /// * delay 重置动画最小延迟时间，默认500毫秒
  // void changeTheme(VoidCallback fun, [int? delay]) =>
  //     GlobalThemeStyle.changeTheme(fun, delay);
}
