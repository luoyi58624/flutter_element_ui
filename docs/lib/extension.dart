import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget mergeTextStyle(TextStyle style) => DefaultTextStyle.merge(
        style: style,
        child: this,
      );

  List<Widget> operator *(int other) {
    return List.generate(other, (index) => this);
  }
}
