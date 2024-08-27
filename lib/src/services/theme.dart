import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

import '../styles/config.dart';
import '../styles/theme.dart';

/// 默认的文本样式
TextStyle defaultTextStyle = TextStyle(
  fontFamily: null,
  fontFamilyFallback: (PlatformUtil.isMacOS || PlatformUtil.isIOS)
      ? ['.AppleSystemUIFont', 'PingFang SC']
      : PlatformUtil.isWindows
          ? ['Microsoft YaHei', '微软雅黑']
          : null,
);

mixin ElThemeService {
  /// 全局文本尺寸，当注入 [ElConfigProvider] 时初始化，如果你没有指定字体尺寸，
  /// 默认情况下在移动端字体为 15 像素，桌面端为 16 像素。
  late double globalFontSize;

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
