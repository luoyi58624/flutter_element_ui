part of '../index.dart';

mixin _HoverMixin<T extends ElEvent> on _CommonMixin<T> {
  /// 是否存在悬停状态依赖，如果没有依赖需要防止不必要的重新渲染
  bool hasHoverDepend = false;

  late final BaseObs<bool>? _hasHover;

  /// 悬停状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool get hasHover => _hasHover?.value ?? false;

  set hasHover(bool value) {
    if (hasHoverDepend) _hasHover!.value = value;
  }

  void setHoverDepend() {
    if (PlatformUtil.isDesktop) {
      hasHoverDepend = true;
    }
  }

  /// 鼠标进入目标区域事件
  void onEnter(PointerEnterEvent e) {
    hasHover = true;
    prop.onEnter?.call(e);
  }

  /// 鼠标离开目标区域事件
  void onExit(PointerExitEvent e) {
    hasHover = false;
    prop.onExit?.call(e);
  }

  @override
  void initState() {
    super.initState();
    if (PlatformUtil.isDesktop) {
      _hasHover = BaseObs(false);
    }
  }

  Widget buildHoverWidget(BuildContext context, Widget child) {
    // 只有在桌面端才渲染鼠标悬停小部件，移动端不存在悬停事件
    if (PlatformUtil.isDesktop) {
      if (prop.disabled) hasHover = false;
      return MouseRegion(
        cursor: prop.cursor,
        hitTestBehavior: prop.behavior,
        onHover: prop.disabled ? null : prop.onHover,
        onEnter: prop.disabled ? null : onEnter,
        onExit: prop.disabled ? null : onExit,
        child: child,
      );
    } else {
      return child;
    }
  }
}
