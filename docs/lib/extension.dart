import 'package:flutter/widgets.dart';
extension WidgetExt on Widget {
  Widget mergeTextStyle(TextStyle style) => DefaultTextStyle.merge(
        style: style,
        child: this,
      );
}
