import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'global.dart';
import 'main.dart';

class GlobalState {
  GlobalState._();

  /// 主题色
  static final primaryColor = LocalObs(
    ElThemeData.theme.primary,
    cacheKey: 'primary_color',
    serialize: const ElColorSerialize(),
  );

  static final _isDark = LocalObs(false, cacheKey: 'isDark');

  /// 当前是否是暗黑主题，当前应用的主题策略是：
  /// * 如果系统是亮色模式，那么允许用户手动切换
  /// * 如果系统已经设置为暗黑模式，那么将强制应用为暗黑模式，不允许手动切换
  static bool get isDark {
    switch (MainApp.currentThemeMode) {
      case ThemeMode.system:
        return _isDark.value;
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
    }
  }

  /// 手动设置暗黑模式，只有当前主题模式是跟随系统时才生效
  static set isDark(bool v) {
    if (MainApp.currentThemeMode == ThemeMode.system) _isDark.value = v;
  }

  static Brightness get brightness =>
      isDark ? Brightness.dark : Brightness.light;

  /// Element UI 组件全局尺寸
  static final globalSize = LocalObs(
    El.medium,
    cacheKey: 'global_size',
  );

  /// 开启边界重绘
  static final enabledRepaintRainbow = WatchObs(
    false,
    watch: (newValue, oldValue) {
      debugRepaintRainbowEnabled = newValue;
    },
  );

  /// 开启重采样机制，开启此功能可以让高刷手机拥有更平滑的触控，但缺点是会带来一点延迟
  static final enableResampling = LocalObs(
    false,
    cacheKey: 'enabled_resampling',
    immediate: true,
    watch: (newValue, oldValue) {
      GestureBinding.instance.resamplingEnabled = newValue;
    },
  );

  /// 开启性能视图
  static final showPerformanceOverlay = Obs(false);

  /// 显示 debug 标识
  static final debugShowCheckedModeBanner =
      LocalObs(true, cacheKey: 'show_debug_banner');

  /// 显示语义调式器
  static final showSemanticsDebugger = Obs(false);

  /// 监控 fps 帧率
  static final fps = LocalObs(false, cacheKey: 'show_fps');

  /// 是否展开代码块
  static final expandedCode = LocalObs(false, cacheKey: 'expanded_code');
}
