import 'dart:math';

import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../generates/components/others/drag_resizer.g.dart';

class ElDragResizer extends StatefulWidget {
  /// 对子组件进行拖拽位置 + 调整尺寸，它必须放置于 [Stack] 小部件中
  const ElDragResizer({
    super.key,
    required this.child,
    required this.initialSize,
    required this.minSize,
    required this.maxSize,
    this.initialPosition,
    this.alignment = Alignment.topLeft,
    this.alignmentOffset = Offset.zero,
    this.disabledDrag = false,
    this.disabledResizer = false,
    this.dragAreaHeight = 20,
    this.cacheKey,
  });

  final Widget child;

  /// Widget 初始尺寸
  final Size initialSize;

  /// 限制 Widget 最小尺寸
  final Size minSize;

  /// 限制 Widget 最大尺寸
  final Size maxSize;

  /// 初始化位置，如果不为 null 它会覆盖 [alignment]
  final Offset? initialPosition;

  /// 初始定位位置，默认：左上角
  final Alignment alignment;

  /// [alignment] 相对偏移位置
  final Offset alignmentOffset;

  /// 是否禁用拖拽移动，默认 false
  final bool disabledDrag;

  /// 是否禁用调整尺寸，默认 false
  final bool disabledResizer;

  /// 拖拽区域高度
  final double dragAreaHeight;

  /// 本地持久化 key
  final String? cacheKey;

  @override
  State<ElDragResizer> createState() => _ElDragResizerState();
}

class _ElDragResizerState extends State<ElDragResizer> {
  late ElDragResizerThemeData themeData;

  final LayerLink layerLink = LayerLink();
  late OverlayEntry overlayEntry;

  late final LocalObs<_ElDragResizerData> localData = ModelObs(
    _ElDragResizerData(
      position: widget.initialPosition,
      size: widget.initialSize,
    ),
    cacheKey: widget.cacheKey,
  );

  late Offset position;

  Size get size {
    return Size(
      min(
        widget.maxSize.width,
        max(widget.minSize.width, localData.value.size!.width),
      ),
      min(
        widget.maxSize.height,
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
                            localData.value = localData.value.copyWith(
                              size: size,
                            );
                            el.cursor.remove();
                          },
                          onPanCancel: () {
                            localData.value = localData.value.copyWith(
                              size: size,
                            );
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
                    if (widget.disabledDrag == false)
                      Positioned(
                        top: triggerSize,
                        left: triggerSize,
                        right: triggerSize,
                        child: GestureDetector(
                          onPanStart: (e){
                            el.cursor.add();
                          },
                          onPanUpdate: (e){
                            localData.value = localData.value.copyWith(
                              position: localData.value.position! + e.delta,
                            );
                          },
                          onPanEnd: (e){
                            el.cursor.remove();
                          },
                          onPanCancel: (){
                            el.cursor.remove();
                          },
                          child: Container(
                            width: triggerSize,
                            height: widget.dragAreaHeight,
                            color: Colors.blue,
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
    position = localData.value.position!;
    localData.addListener(() {
      if (position != localData.value.position) {
        setState(() {
          position = localData.value.position!;
        });
      }
    });
  }

  @override
  void dispose() {
    overlayEntry.remove();
    overlayEntry.dispose();
    super.dispose();
    localData.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = ElDragResizerTheme.of(context);
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: CompositedTransformTarget(
        link: layerLink,
        child: UnconstrainedBox(
          child: ObsBuilder(builder: (context) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: widget.child,
            );
          }),
        ),
      ),
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

@ElModel.copy()
@ElThemeModel(desc: '支持拖拽、调整 Widget 尺寸小部件默认样式')
class ElDragResizerThemeData {
  static const _defaultTheme = ElDragResizerThemeData(
    triggerSize: 8,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElDragResizerThemeData({
    this.triggerSize,
  });

  /// 拖拽控件触发范围，默认 8。
  ///
  /// 注意：[triggerSize] 必须大于 [size]，否则会抛出异常。
  final double? triggerSize;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
