import 'package:flutter/widgets.dart';

import 'service.dart';

mixin ElCursorService {
  OverlayEntry? _overlayEntry;

  /// 设置全局光标，它会在当前页面上方创建一层完全透明的遮罩，它本身不接收任何事件，
  /// 只会捕获全局鼠标光标悬停样式。
  ///
  /// 适用场景：拖拽滚动条、拖拽元素尺寸、全局 loading 禁止点击...
  void setCursor([MouseCursor? cursor]) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => MouseRegion(
          cursor: cursor ?? MouseCursor.defer,
          child: const SizedBox(),
        ),
      );
      Overlay.of(el.context).insert(_overlayEntry!);
    }
  }

  /// 重置全局光标
  void resetCursor() {
    if (_overlayEntry != null) {}
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
