import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../components/basic/scrollbar.dart';

class _CustomScrollBehavior extends ScrollBehavior {
  const _CustomScrollBehavior();

  @override
  Widget buildOverscrollIndicator(context, child, details) {
    // 如果是安卓平台，统一使用 M3 的过度滚动效果
    if (PlatformUtil.isAndroid) {
      return StretchingOverscrollIndicator(
        axisDirection: details.direction,
        child: child,
      );
    } else {
      return child;
    }
  }
}

class ElScrollBehavior extends _CustomScrollBehavior {
  /// 设置全局默认的滚动条，在桌面端将使用[ElScrollbar]
  const ElScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    if (PlatformUtil.isWindows ||
        PlatformUtil.isMacOS ||
        PlatformUtil.isLinux) {
      return ElScrollbar(
        controller: details.controller,
        child: child,
      );
    }
    if (PlatformUtil.isIOS) {
      return CupertinoScrollbar(
        controller: details.controller,
        child: child,
      );
    }
    return Scrollbar(
      controller: details.controller,
      child: child,
    );
  }
}

class ElNoScrollBehavior extends _CustomScrollBehavior {
  /// 不使用任何默认滚动条
  const ElNoScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) => child;
}
