import 'package:flutter/material.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/scroll.g.dart';

@ElModel.copy()
class ElScrollConfigurationData {
  /// 过度滚动时是否禁用波纹效果 - Material2
  final bool disabledRipper;

  /// 波纹颜色 - Material2
  final Color ripperColor;

  ElScrollConfigurationData({
    this.disabledRipper = false,
    this.ripperColor = Colors.grey,
  });
}

// @ElModel.copy()
// class ElScrollStyle {}
