import 'package:flutter/widgets.dart';

import '../element_plus.dart';

/// 小部件构建器
typedef ElWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// 滚动条小部件构建器
typedef ElScrollbarBuilder = Widget Function(
  BuildContext context,
  ScrollController controller,
  Widget child,
);

/// 自定义消息构建
typedef ElMessageBuilder = Widget Function(
  BuildContext context,
  ElMessageModel message,
);

/// 自定义轻提示构建
typedef ElToastBuilder = Widget Function(
  BuildContext context,
  dynamic content,
);

/// 返回值为空函数回调，但接收一个 bool 值
typedef ElBoolVoidCallback = void Function(bool value);

/// 当拖拽发生更新时，响应的事件
typedef ElDragChanged = void Function(ElDragChangedData e);
