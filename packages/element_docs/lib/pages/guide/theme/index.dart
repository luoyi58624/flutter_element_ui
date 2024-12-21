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
    apply('hello');
    apply(10);
    apply(10.0);
    apply(true);

    Object hello = Object();
    apply(hello);

    dynamic hello2 = 'xx';
    apply(hello2);
    return [];
  }

  T apply<T>(T value) {
    i(T.toString(), value is Color);
    return value;
  }
}
