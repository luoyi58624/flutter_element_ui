import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/platform/platform.dart';

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();

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

class NoScrollBehavior extends CustomScrollBehavior {
  /// 不使用任何默认滚动条
  const NoScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) => child;
}

class RawScrollBehavior extends CustomScrollBehavior {
  /// 将原生滚动条作为默认的滚动行为
  const RawScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    return RawScrollbar(
      controller: details.controller,
      child: child,
    );
  }
}

class MaterialScrollBehavior extends CustomScrollBehavior {
  /// 将 Material 滚动条作为默认的滚动行为
  const MaterialScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    return Scrollbar(
      controller: details.controller,
      child: child,
    );
  }
}

class CupertinoScrollBehavior extends CustomScrollBehavior {
  const CupertinoScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    /// 将 Cupertino 滚动条作为默认的滚动行为
    return CupertinoScrollbar(
      controller: details.controller,
      child: child,
    );
  }
}
