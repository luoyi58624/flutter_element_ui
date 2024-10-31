import 'package:flutter/widgets.dart';

/// 桌面端开始拖拽延迟时间
const desktopDragTimeout = Duration(milliseconds: 100);

/// 将回调函数添加到下一帧执行
void nextTick(VoidCallback fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fun();
  });
}
