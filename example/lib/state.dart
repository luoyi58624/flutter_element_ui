import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

import 'global.dart';

class GlobalState {
  /// 开启暗黑模式
  static final isDark = Obs(false);

  /// 开启边界重绘
  static final enabledRepaintRainbow = Obs(
    false,
    immediate: true,
    watch: (newValue, oldValue) {
      debugRepaintRainbowEnabled = newValue;
    },
  );

  /// 开启重采样机制，开启此功能可以让高刷手机拥有更平滑的触控，但缺点是会带来一点延迟
  static final enableResampling = Obs(
    false,
    immediate: true,
    watch: (newValue, oldValue) {
      GestureBinding.instance.resamplingEnabled = newValue;
    },
  );

  /// 开启性能视图
  static final showPerformanceOverlay = Obs(false);

  /// 滚动组件下方是否插入[RepaintBoundary]
  static final scrollRepaintBoundary = Obs(true);
}
