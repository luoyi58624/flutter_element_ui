import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'theme.dart';

part '../../../generates/components/others/resizer/index.g.dart';

class ElResizer extends StatefulWidget {
  /// 调整 Widget 尺寸小部件，注意：被包裹的小部件所在的容器必须明确宽高
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

  late BoxConstraints _constraints;
  late final LocalObs<Size> _size = LocalObs(
    widget.initialSize,
    cacheKey: widget.cacheKey,
  );

  Size get size => _size.value;

  void setSize(Offset offset) {
    size + offset;
  }

  void insertOverlay() {
    overlayEntry = OverlayEntry(builder: (context) {
      final triggerSize = themeData.triggerSize!;
      final offset = Offset(-triggerSize, -triggerSize);
      return UnconstrainedBox(
        child: CompositedTransformFollower(
          link: layerLink,
          offset: offset,
          child: ObsBuilder(
              binding: [_size],
              builder: (context) {
                return Stack(
                  children: [
                    IgnorePointer(
                      child: Container(
                        width: size.width + triggerSize * 2,
                        height: size.height + triggerSize * 2,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                      ),
                    ),
                    // top
                    Positioned(
                      top: 0,
                      left: triggerSize,
                      right: triggerSize,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeRow,
                        child: Container(
                          height: triggerSize,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    // right
                    Positioned(
                      top: triggerSize,
                      bottom: triggerSize,
                      right: 0,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeColumn,
                        child: Container(
                          width: triggerSize,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    // bottom
                    Positioned(
                      bottom: 0,
                      left: triggerSize,
                      right: triggerSize,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeRow,
                        child: Container(
                          height: triggerSize,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    // left
                    Positioned(
                      top: triggerSize,
                      bottom: triggerSize,
                      left: 0,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeColumn,
                        child: Container(
                          width: triggerSize,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    // top - right 对角
                    Positioned(
                      top: 0,
                      right: 0,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeUpRightDownLeft,
                        child: Container(
                          width: triggerSize,
                          height: triggerSize,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // right - bottom 对角
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeUpLeftDownRight,
                        child: GestureDetector(
                          onPanStart: (e) {
                            el.cursor
                                .add(SystemMouseCursors.resizeUpLeftDownRight);
                          },
                          onPanUpdate: (e) {
                            _size.value = size + e.delta;
                          },
                          onPanEnd: (e) {
                            el.cursor.remove();
                          },
                          onPanCancel: () {
                            el.cursor.remove();
                          },
                          child: Container(
                            width: triggerSize,
                            height: triggerSize,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    // bottom - left 对角
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeUpRightDownLeft,
                        child: Container(
                          width: triggerSize,
                          height: triggerSize,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    // left - top 对角
                    Positioned(
                      top: 0,
                      left: 0,
                      child: MouseRegion(
                        hitTestBehavior: HitTestBehavior.opaque,
                        cursor: SystemMouseCursors.resizeUpLeftDownRight,
                        child: Container(
                          width: triggerSize,
                          height: triggerSize,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              }),
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
    return LayoutBuilder(builder: (context, constraints) {
      assert(
          constraints.maxWidth != double.infinity &&
              constraints.maxHeight != double.infinity,
          '被 ElResizer 包裹的小部件所在的容器必须指定最大宽高，不能是 double.infinity 无限尺寸');
      _constraints = constraints;
      return CompositedTransformTarget(
        link: layerLink,
        child: ObsBuilder(builder: (context) {
          return widget.builder(size);
        }),
      );
    });
  }
}
