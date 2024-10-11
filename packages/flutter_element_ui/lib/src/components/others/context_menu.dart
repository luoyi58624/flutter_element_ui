import 'package:flutter/gestures.dart';
import 'package:flutter_element_ui/src/global.dart';

Offset _localPosition = Offset.zero;

class ElContextMenu extends StatelessWidget {
  /// 右键菜单小部件
  const ElContextMenu({
    super.key,
    required this.child,
    this.disabled = false,
    this.disabledLongPress = false,
    this.on,
  });

  final Widget child;

  /// 是否禁用
  final bool disabled;

  /// 如果是移动端，是否禁用长按触摸事件
  final bool disabledLongPress;

  /// 右键触发事件，会传递当前坐标点
  final void Function(Offset offset)? on;

  void _handler() {
    if (on != null) {
      on!(_localPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    if (PlatformUtil.isMobile && !disabledLongPress) {
      result = GestureDetector(
        onLongPress: () {
          _handler();
        },
        child: child,
      );
    }
    if (!disabled) {
      result = Listener(
        onPointerDown: (e) {
          if (e.kind == PointerDeviceKind.mouse &&
              e.buttons == kSecondaryMouseButton) {
            _localPosition = e.position;
            if (PlatformUtil.isDesktop) _handler();
          }
        },
        child: result,
      );
    }
    return result;
  }
}
