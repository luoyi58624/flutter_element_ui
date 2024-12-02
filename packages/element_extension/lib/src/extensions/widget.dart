import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  List<Widget> operator *(int other) {
    return List.generate(other, (index) => this);
  }
}
