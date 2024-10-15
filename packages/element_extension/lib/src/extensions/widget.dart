import 'package:flutter/widgets.dart';

import '../widgets/scroll_behavior.dart';

extension ElWidgetExtension on Widget {
  /// 不使用祖先提供的默认滚动条
  Widget get noScrollBehavior => ScrollConfiguration(
        behavior: const NoScrollBehavior(),
        child: this,
      );

  /// 将 [Scrollbar] 作为默认滚动条
  Widget get materialScrollBehavior => ScrollConfiguration(
        behavior: const MaterialScrollBehavior(),
        child: this,
      );

  /// 使用 [CupertinoScrollbar] 作为默认滚动条
  Widget get cupertinoScrollBehavior => ScrollConfiguration(
        behavior: const CupertinoScrollBehavior(),
        child: this,
      );
}
