import 'package:flutter/widgets.dart';

import '../core.dart';

mixin ElHoverService {
  OverlayEntry? _overlayEntry;

  /// 设置全局光标
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
