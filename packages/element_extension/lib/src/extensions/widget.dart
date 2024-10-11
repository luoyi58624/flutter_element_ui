import 'package:flutter/widgets.dart';

import '../widgets/scroll_behavior.dart';

extension ElWidgetExtension on Widget {
  /// 不使用祖先提供的默认滚动条，如果你希望当前滚动小部件不使用滚动条，或者你正在使用自定义滚动条，
  /// 那么只需在小部件的末尾添加这个扩展方法即可
  Widget get noScrollBehavior => ScrollConfiguration(
        behavior: const NoScrollBehavior(),
        child: this,
      );
}
