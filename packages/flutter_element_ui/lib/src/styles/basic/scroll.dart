import 'package:flutter/material.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/scroll.g.dart';

@ElModel.copy()
class ElScrollConfigurationData {
  /// 全局滚动配置
  const ElScrollConfigurationData({
    this.forceM2 = false,
    this.forceM3 = false,
    this.disabledRipper = false,
    this.ripperColor = Colors.grey,
  });

  /// 强制安卓平台应用 Material2 的滚动效果，M2过度滚动是一个波纹
  final bool forceM2;

  /// 强制安卓平台应用 Material3 的滚动效果，M3过度滚动是一个拉伸
  final bool forceM3;

  /// 如果是 M2 过度滚动时，是否禁用波纹效果
  final bool disabledRipper;

  /// 如果是 M2 过度滚动时，指定波纹颜色
  final Color ripperColor;
}

// @ElModel.copy()
// class ElScrollStyle {}
