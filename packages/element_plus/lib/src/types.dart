import 'package:flutter/widgets.dart';

import 'services/message.dart';

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
