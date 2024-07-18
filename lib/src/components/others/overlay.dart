import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// Element UI 弹窗组件基类
abstract class ElOverlay extends StatefulWidget {
  const ElOverlay({super.key});

  @override
  State<ElOverlay> createState() => ElOverlayState();
}

class ElOverlayState extends State<ElOverlay> {
  /// 是否显示弹窗
  final showOverlay = Obs(false);

  /// 监听 build 函数的更新，每次触发 build 都会更新此状态，然后同步构建 Overlay 组件
  final buildKey = Obs(0);

  /// 链接目标元素和弹窗
  final LayerLink layerLink = LayerLink();

  /// 引用弹窗元素 key
  final GlobalKey contentKey = GlobalKey();
  late OverlayEntry overlayEntry;
  Timer? _delayHideOverlay;
  Size? _contentSize;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
