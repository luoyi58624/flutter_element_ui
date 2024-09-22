import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../service.dart';
import '../utils/common.dart';
import '../utils/platform/platform.dart';

mixin CursorService {
  /// 全局光标实例对象
  final CursorInstance cursor = CursorInstance();
}

class CursorInstance {
  OverlayEntry? _overlayEntry;

  /// 全局光标响应式变量
  final Obs<MouseCursor> _cursor = Obs(MouseCursor.defer);

  /// 设置全局光标，它会在页面上方创建一层完全透明的遮罩，防止页面中其他元素捕获悬停状态，
  /// 如果遮罩已存在，则仅更新全局光标。
  void set([MouseCursor? cursor]) {
    if (ElPlatform.isDesktop && _cursor.value != cursor) {
      ElUtils.nextTick(() {
        _cursor.value = cursor ?? MouseCursor.defer;
        if (_overlayEntry == null) {
          _overlayEntry = OverlayEntry(
            builder: (context) => ObsBuilder(builder: (context) {
              return MouseRegion(
                cursor: _cursor.value,
                child: const SizedBox(),
              );
            }),
          );

          Overlay.of(el.context).insert(_overlayEntry!);
        }
      });
    }
  }

  /// 移除全局光标
  void remove() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      ElUtils.nextTick(() {
        _cursor.value = MouseCursor.defer;
      });
    }
  }
}
