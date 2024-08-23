import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../styles/config.dart';
import '../styles/theme.dart';

/// 当前应用的主题模式，每次构建 [ElConfigProvider] 时，都会将 themeMode 参数传递给此变量，
/// 如果指定跟随系统，同时当前平台启用了全局暗黑模式，那么此变量将强制为 dark，
ThemeMode currentThemeMode = ThemeMode.system;

/// 默认的文本样式
TextStyle defaultTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: null,
  fontFamilyFallback: (PlatformUtil.isMacOS || PlatformUtil.isIOS)
      ? ['.AppleSystemUIFont', 'PingFang SC']
      : PlatformUtil.isWindows
          ? ['Microsoft YaHei', '微软雅黑']
          : null,
);

mixin ElThemeService {
  /// 全局文本尺寸
  double globalFontSize = defaultTextStyle.fontSize!;

  final _isDark = Obs(false);

  /// 当前是否是暗黑主题
  bool get isDark {
    switch (currentThemeMode) {
      case ThemeMode.system:
        return _isDark.value;
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
    }
  }

  /// 手动设置暗黑模式，如果 [ElConfigProvider] 参数 themeMode 强制指定 light 或 dark，
  /// 或者用户开启了全局暗黑模式，响应式变量将无法更新
  set isDark(bool v) {
    if (currentThemeMode == ThemeMode.system) _isDark.value = v;
  }

  Brightness get brightness => isDark ? Brightness.dark : Brightness.light;

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

  /// Element UI 全局响应式断点。
  ///
  /// 提示：这是通用的响应式断点方案，涵盖 320px -> 2560px 范围设备的断点，你可以使用它，
  /// 但不允许自定义，因为会破坏很多组件的响应式逻辑，它的逻辑十分简单，想要自定义方案请自行封装。
  ///
  /// xs、sm、md、lg、xl 等扩展函数没有暴露给外部，如果你需要请自己进行封装，只需将
  /// GlobalConfig.responsive -> el.responsive 即可。
  ResponsiveData get responsive => GlobalConfig.responsive;
}
