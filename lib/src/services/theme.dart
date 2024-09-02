import 'package:flutter_element_ui/global.dart';

import '../styles/config.dart';
import '../styles/theme.dart';

mixin ElThemeService {
  /// 全局主题过渡持续时间。
  ///
  /// [MaterialApp] 提供了 themeAnimationDuration 属性，如果你有切换黑暗模式的需求，
  /// 那么你应当将此属性和 MaterialApp 进行同步，这样可以防止切换暗黑模式时颜色过渡出现不一致问题。
  Duration get themeDuration => GlobalConfig.themeDuration;

  set themeDuration(Duration v) {
    GlobalConfig.themeDuration = v;
  }

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

  /// Element UI 全局响应式断点，这是通用的响应式断点方案，涵盖 320px -> 2560px 范围设备的断点，
  /// 你可以使用它，但不允许自定义，因为会破坏很多组件的响应式逻辑。
  ResponsiveData get responsive => GlobalConfig.responsive;
}
