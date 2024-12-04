import 'dart:async';

import 'package:flutter/widgets.dart';

/// 将回调函数添加到下一帧执行
void nextTick(VoidCallback fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fun();
  });
}

/// 延迟指定时间执行函数，单位：毫秒
Timer setTimeout(void Function() fun, int wait) {
  assert(wait >= 0);
  return Timer(Duration(milliseconds: wait), fun);
}

/// 每隔一段时间执行函数，单位：毫秒
Timer setInterval(void Function() fun, int wait) {
  assert(wait >= 0);
  return Timer.periodic(Duration(milliseconds: wait), (e) {
    fun();
  });
}
