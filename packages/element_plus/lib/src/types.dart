import 'package:flutter/widgets.dart';

import 'services/message.dart';

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
