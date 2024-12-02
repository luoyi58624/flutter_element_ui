import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/widgets.dart';

extension FlutterWidgetExtension on Widget {
  /// 不使用祖先提供的默认滚动条，添加此扩展方法可以防止使用自定义滚动条时引起重叠问题
  Widget get noScrollBehavior => ScrollConfiguration(
        behavior: const NoScrollBehavior(),
        child: this,
      );
}
