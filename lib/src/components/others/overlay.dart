import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

/// Element UI 弹窗组件基类
abstract class ElOverlay extends StatefulWidget {
  const ElOverlay({super.key});

  @override
  State<ElOverlay> createState();
}

abstract class ElOverlayState<T extends ElOverlay> extends State<T> {
  /// 是否显示弹窗
  final showOverlay = Obs(false);

  /// 监听 build 函数的更新，每次触发 build 都会更新此状态，然后同步构建 Overlay 组件
  final buildCount = Obs(0);

  /// 链接目标元素和弹窗
  final LayerLink layerLink = LayerLink();

  /// 引用弹窗元素 key
  final GlobalKey contentKey = GlobalKey();
  late OverlayEntry overlayEntry;

  /// 延迟隐藏浮窗计时器
  Timer? hideOverlayTimer;

  /// 弹窗内容的尺寸
  Size? contentSize;

  /// Overlay 小部件
  late final Widget overlayWidget = ObsBuilder(
      watch: [buildCount],
      builder: (_) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(Offset.zero);
        bool isUp = offset.dy > 100;
        nextTick(() {
          _setContentSize();
          // i(_contentSize, 'build');
        });
        return Offstage(
          offstage: !showOverlay.value,
          child: UnconstrainedBox(
            child: CompositedTransformFollower(
              link: layerLink,
              targetAnchor: isUp ? Alignment.topCenter : Alignment.bottomCenter,
              followerAnchor:
                  isUp ? Alignment.bottomCenter : Alignment.topCenter,
              child: buildContent(context),
            ),
          ),
        );
      });

  void hideOverlay() {
    showOverlay.value = false;
    hideOverlayTimer = null;
  }

  void _setContentSize() {
    final RenderBox contentBox =
        contentKey.currentContext!.findRenderObject()! as RenderBox;
    contentSize = contentBox.size;
  }

  Widget buildChild(BuildContext context);

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    buildCount.value++;
    return CompositedTransformTarget(
      link: layerLink,
      child: buildChild(context),
    );
  }
}
