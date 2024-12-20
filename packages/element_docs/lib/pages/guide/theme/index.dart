import 'package:element_docs/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemePage extends ResponsivePage {
  const ThemePage({super.key});

  @override
  String get title => '主题';

  @override
  List<Widget> buildPage(BuildContext context) {
    apply(const Color.fromRGBO(255, 255, 255, 1.0));
    apply(Colors.red);
    return [];
  }

  T apply<T>(T value) {
    i(T.toString(), value is Color);
    return value;
  }
}
