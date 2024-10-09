import 'package:flutter/widgets.dart';

/// 添加下一帧执行的回调函数，它会在 build 完成后执行
void nextTick(VoidCallback fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fun();
  });
}
