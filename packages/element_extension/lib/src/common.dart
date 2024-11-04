import 'package:flutter/widgets.dart';

/// 将回调函数添加到下一帧执行
void nextTick(VoidCallback fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fun();
  });
}
