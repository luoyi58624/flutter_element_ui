import 'dart:math';

import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../../core.dart';
import '../../../hooks/obs.dart';
import '../../../utils/assert.dart';

part 'split_panel.dart';

part 'split_resizer.dart';

/// 分割组件抽象类，它包含两种子类：分割面板、分割条
abstract class ElSplitWidget extends StatelessWidget {
  const ElSplitWidget({super.key});
}

/// 分割面板抽象类，它支持两种分割布局：SizedBox、Flex
abstract class _ElSplitPanelWidget extends ElSplitWidget {
  const _ElSplitPanelWidget({
    super.key,
    this.cacheKey,
  });

  /// 持久化缓存key，注意不要重复，它必须是唯一的
  final String? cacheKey;

  /// 当前布局id，分割面板和分割条就是通过它进行绑定的
  String get id => cacheKey ?? hashCode.toString();
}

/// 以 [SizedBox] 为基础的传统分割面板组件，它以实际像素来计算拖拽的尺寸
abstract class ElSplitSizePanel extends _ElSplitPanelWidget {
  const ElSplitSizePanel({
    super.key,
    required this.size,
    this.minSize = 0,
    this.maxSize,
    super.cacheKey,
  }) : assert(minSize >= 0);

  /// 布局默认尺寸
  final double size;

  /// 最小尺寸，必须大于等于0
  final double minSize;

  /// 最大尺寸，该值必须由你根据业务手动指定，如果不传，几乎必定引起边界异常
  final double? maxSize;
}

/// 以 [Expanded] 为基础的弹性分割面板组件，它按比例来计算拖拽的尺寸。
///
/// 注意：如果分割面板容器已存在[ElSplitSizePanel]，那么弹性分割面板最多只能有一个。
abstract class ElSplitFlexPanel extends _ElSplitPanelWidget {
  const ElSplitFlexPanel({
    super.key,
    this.flex = 1,
    this.minFlex,
    this.maxFlex,
    this.minSize = 0,
    this.maxSize,
    super.cacheKey,
  }) : assert(minSize >= 0);

  /// 定义弹性盒子分配的空间比例
  final int flex;

  /// 最大flex
  final int? minFlex;

  /// 最小flex
  final int? maxFlex;

  /// 最小尺寸，必须大于等于0
  final double minSize;

  /// 最大尺寸
  final double? maxSize;
}
