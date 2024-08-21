import 'package:flutter/widgets.dart';

import '../service.dart';

mixin ElCursorService {
  /// 设置全局光标实例对象
  final ElCursorInstance globalCursor = ElCursorInstance();
}

class ElCursorInstance {
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

  /// 重置全局光标
  void resetCursor() {
    // setCursor 和 resetCursor 必须是配套的，所以这里使用 assert 而不是 if
    assert(_overlayEntry != null);
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}
