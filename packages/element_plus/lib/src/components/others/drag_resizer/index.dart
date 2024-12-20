import 'dart:math';

import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/drag_resizer/index.g.dart';

class ElDragResizer extends StatefulWidget {
  /// 对子组件进行拖拽位置 + 调整尺寸，它必须放置于 [Stack] 小部件中
  const ElDragResizer({
    super.key,
    required this.initialPosition,
    required this.initialSize,
    this.minSize = Size.zero,
    this.maxSize,
    this.cacheKey,
    required this.builder,
  });

  /// 初始化位置
  final Offset initialPosition;

  /// Widget 初始尺寸
  final Size initialSize;

  /// 限制 Widget 最小尺寸，宽高必须大于等于0
  final Size minSize;

  /// 限制 Widget 最大尺寸，如果为 null，那么你必须指定当前容器的最大宽高
  final Size? maxSize;

  /// 本地持久化 key
  final String? cacheKey;

  /// 尺寸回调
  final Widget Function(Size size) builder;

  @override
  State<ElDragResizer> createState() => _ElDragResizerState();
}

class _ElDragResizerState extends State<ElDragResizer> {
  late ElDragResizerThemeData themeData;
  late Size maxSize;

  final LayerLink layerLink = LayerLink();
  late OverlayEntry overlayEntry;

  late final LocalObs<_ElDragResizerData> localData = ModelObs(
    _ElDragResizerData(
      position: widget.initialPosition,
      size: widget.initialSize,
    ),
    cacheKey: widget.cacheKey,
  );

  Size get size {
    return Size(
      min(
        maxSize.width,
        max(widget.minSize.width, localData.value.size!.width),
      ),
      min(
        maxSize.height,
        max(widget.minSize.height, localData.value.size!.height),
      ),
    );
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
              binding: [localData],
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
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: triggerSize,
                            height: triggerSize,
                            color: Colors.red,
                          ),
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
                          behavior: HitTestBehavior.opaque,
                          onPanStart: (e) {
                            el.cursor
                                .add(SystemMouseCursors.resizeUpLeftDownRight);
                          },
                          onPanUpdate: (e) {
                            localData.value = localData.value.copyWith(
                              size: localData.value.size! + e.delta,
                            );
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
    themeData = ElDragResizerTheme.of(context);

    nextTick(() {
      i(context.size);
    });
    return Positioned(
      left: 0,
      top: 0,
      child: LayoutBuilder(builder: (context, constraints) {
        if (widget.maxSize != null) {
          maxSize = widget.maxSize!;
        } else {
          maxSize = Size(constraints.maxWidth, constraints.maxHeight);
        }
        // assert(
        //     constraints.maxWidth != double.infinity &&
        //         constraints.maxHeight != double.infinity,
        //     '你没有指定 ElResizer 的最大宽高，那么你必须小部件所在容器的最大宽高，不能是 double.infinity 无限尺寸');
        // maxSize = Size(constraints.maxWidth, constraints.maxHeight);
        return ObsBuilder(builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: CompositedTransformTarget(
              link: layerLink,
              child: ObsBuilder(builder: (context) {
                return widget.builder(size);
              }),
            ),
          );
        });
      }),
    );
  }
}

@ElModel.all()
class _ElDragResizerData implements ElSerializeModel {
  @ElOffsetSerialize()
  Offset? position;

  @ElSizeSerialize()
  Size? size;

  _ElDragResizerData({this.position, this.size});

  @override
  _ElDragResizerData fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
