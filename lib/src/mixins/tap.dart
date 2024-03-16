part of flutter_element_ui;

/// 鼠标点击混入，解决适配桌面端编写大量模拟点击样式的样板代码
mixin ElTapMixin<T extends StatefulWidget, D> on State<T> {
  /// 鼠标是否按下
  bool onTap = false;

  /// 是否禁用点击事件
  bool get disabledTap => false;

  /// 自定义点击事件
  void onTapEvent() {}

  /// 构建鼠标悬停样式组件
  Widget buildTapWidget({required Widget child}) {
    return GestureDetector(
      onTapDown: disabledTap
          ? null
          : (e) {
              setState(() {
                onTap = true;
              });
            },
      onTapCancel: disabledTap
          ? null
          : () {
              setState(() {
                onTap = false;
              });
            },
      onTap: disabledTap
          ? null
          : () {
              setState(() {
                onTap = false;
              });
              onTapEvent();
            },
      child: child,
    );
  }
}
