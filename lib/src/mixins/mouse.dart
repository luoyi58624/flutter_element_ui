part of flutter_element_ui;

/// 鼠标悬停混入，解决适配桌面端编写大量模拟hover样式的样板代码
mixin ElMouseMixin<T extends StatefulWidget, D> on State<T> {
  /// 鼠标是否悬停
  bool onHover = false;

  /// 是否禁用悬停事件
  bool get disabledHover => false;

  /// 鼠标悬停光标样式
  MouseCursor get cursor => disabledHover ? SystemMouseCursors.forbidden : SystemMouseCursors.click;

  /// 自定义鼠标进入元素事件
  void onEnterEvent(PointerEnterEvent event) {}

  /// 自定义鼠标离开元素事件
  void onExitEvent(PointerExitEvent event) {}

  /// 构建鼠标悬停样式组件
  Widget buildMouseWidget({required Widget child}) {
    return MouseRegion(
      onEnter: disabledHover
          ? null
          : (e) {
              setState(() {
                onHover = true;
              });
              onEnterEvent(e);
            },
      onExit: disabledHover
          ? null
          : (e) {
              setState(() {
                onHover = false;
              });
              onExitEvent(e);
            },
      cursor: cursor,
      child: child,
    );
  }
}
