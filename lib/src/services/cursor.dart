import 'package:flutter/widgets.dart';

import 'service.dart';

mixin ElCursorService {
  OverlayEntry? _overlayEntry;

  /// 设置全局光标，它会在页面上方创建一层完全透明的遮罩，然后捕获全局鼠标光标悬停样式，
  /// 这样可以完全屏蔽页面中其他元素的悬停状态。
  ///
  /// 适用场景：拖拽滚动条、拖拽元素尺寸...
  void setCursor([MouseCursor? cursor]) {
    assert(_overlayEntry == null);
    _overlayEntry = OverlayEntry(
      builder: (context) => MouseRegion(
        cursor: cursor ?? MouseCursor.defer,
        child: const SizedBox(),
      ),
    );
    Overlay.of(el.context).insert(_overlayEntry!);
  }

  /// 重置全局光标，移除页面上的遮罩层
  void resetCursor() {
    assert(_overlayEntry != null);
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
