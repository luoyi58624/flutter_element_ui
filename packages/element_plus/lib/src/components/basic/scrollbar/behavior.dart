part of 'index.dart';

class ElScrollBehavior extends CustomScrollBehavior {
  /// Element UI 默认的滚动行为，在桌面端默认使用 [ElScrollbar]
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
