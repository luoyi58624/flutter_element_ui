import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../service.dart';

mixin ElContextMenuService {
  /// 全局右键菜单实例
  final ElContextMenuInstance contextMenu = ElContextMenuInstance();
}

class ElContextMenuInstance {
  /// 保存用户鼠标点击的全局坐标点
  Offset localPosition = Offset.zero;
}

/// 全局右键菜单监听器
class ContextMenuListenerWidget extends StatelessWidget {
  const ContextMenuListenerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        if (e.kind == PointerDeviceKind.mouse &&
            e.buttons == kSecondaryMouseButton) {
          // i(e);
          el.contextMenu.localPosition = e.localPosition;
        }
      },
      child: child,
    );
  }
}
