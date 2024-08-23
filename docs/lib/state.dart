import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'global.dart';

/// 当前应用的主题模式，如果指定跟随系统，同时当前平台启用了全局暗黑模式，那么此变量将强制为 dark
late ThemeMode currentThemeMode;

class GlobalState {
  GlobalState._();

  static final _isDark = Obs(false);

  /// 当前是否是暗黑主题
  static bool get isDark {
    switch (currentThemeMode) {
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
    if (currentThemeMode == ThemeMode.system) _isDark.value = v;
  }

  static Brightness get brightness =>
      isDark ? Brightness.dark : Brightness.light;

  /// 开启边界重绘
  static final enabledRepaintRainbow = Obs(
    false,
    watch: (newValue, oldValue) {
      debugRepaintRainbowEnabled = newValue;
    },
  );

  /// 开启重采样机制，开启此功能可以让高刷手机拥有更平滑的触控，但缺点是会带来一点延迟
  static final enableResampling = Obs(
    false,
    watch: (newValue, oldValue) {
      GestureBinding.instance.resamplingEnabled = newValue;
    },
  );

  /// 开启性能视图
  static final showPerformanceOverlay = Obs(false);

  /// 滚动组件下方是否插入[RepaintBoundary]
  static final scrollRepaintBoundary = Obs(true);
}
