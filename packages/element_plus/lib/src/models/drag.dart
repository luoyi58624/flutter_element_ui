import 'package:flutter/gestures.dart';

class ElDragChangedData {
  /// 当前拖拽的偏移值
  final Offset dragOffset;

  /// 距离上次拖拽的事件产生的更新
  final Offset details;

  ElDragChangedData({
    required this.dragOffset,
    required this.details,
  });
}
