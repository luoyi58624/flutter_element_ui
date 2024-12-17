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
    return [
      TriggerOffsetDraggable(
        rootOverlay: true,
        feedback: Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
        childWhenDragging: const SizedBox(
          width: 100,
          height: 100,
        ),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
        ),
      ),
      Container(
        height: 1000,
        color: Colors.blueGrey,
      ),
    ];
  }
}
