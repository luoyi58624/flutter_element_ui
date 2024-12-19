import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'theme.dart';

part '../../../generates/components/others/resizer/index.g.dart';

class ElResizer extends StatefulWidget {
  /// 调整 Widget 尺寸小部件
  const ElResizer({
    super.key,
    required this.initialSize,
    this.minSize,
    this.maxSize,
    this.cacheKey,
    required this.builder,
  });

  /// Widget 初始尺寸
  final Size initialSize;

  /// 限制 Widget 最小尺寸
  final Size? minSize;

  /// 限制 Widget 最大尺寸
  final Size? maxSize;

  /// 本地持久化 key
  final String? cacheKey;

  /// 尺寸回调
  final Widget Function(Size size) builder;

  @override
  State<ElResizer> createState() => _ElResizerState();
}

class _ElResizerState extends State<ElResizer> {
  late ElResizerThemeData themeData;

  final LayerLink layerLink = LayerLink();
  late OverlayEntry overlayEntry;

  late final LocalObs<Size> _size = LocalObs(
    widget.initialSize,
    cacheKey: widget.cacheKey,
  );

  Size get size => _size.value;

  void insertOverlay() {
    overlayEntry = OverlayEntry(builder: (context) {
      return UnconstrainedBox(
        child: CompositedTransformFollower(
          link: layerLink,
          child: MouseRegion(
            hitTestBehavior: HitTestBehavior.opaque,
            cursor: SystemMouseCursors.resizeRow,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: size.width,
                height: 8,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
    });

    nextTick(() {
      Overlay.of(context).insert(overlayEntry);
    });
  }

  @override
  void initState() {
    super.initState();
    insertOverlay();
  }

  @override
  void dispose() {
    overlayEntry.remove();
    overlayEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = ElResizerTheme.of(context);
    return CompositedTransformTarget(
      link: layerLink,
      child: ObsBuilder(builder: (context) {
        return widget.builder(size);
      }),
    );
  }
}
