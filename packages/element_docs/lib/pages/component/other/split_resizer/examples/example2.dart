import 'dart:math';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends HookWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends StatefulWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  double height = 300;
  double _top = 100;

  void onChanged(double value) {
    setState(() {
      _top += value;
    });
  }

  void onEnd() {
    setState(() {
      _top = min(max(_top, 0), height);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double top = min(max(_top, 0), height);
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: top,
              color: Colors.green,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: top,
            bottom: 0,
            child: Container(
              height: double.infinity,
              color: Colors.grey,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: top,
            bottom: 0,
            child: ElSplitResizerTheme(
              data: ElSplitResizerThemeData(
                axis: Axis.horizontal,
                // 避免匿名函数，否则每次 build 主题对象将不一致，
                // 造成分割器 Overlay 不断删除、插入
                onChanged: onChanged,
                onEnd: onEnd,
              ),
              child: const ElSplitResizer(),
            ),
          ),
        ],
      ),
    );
  }
}

String get code => '''
class _Example extends StatefulWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  double height = 300;
  double _top = 100;

  void onChanged(double value) {
    setState(() {
      _top += value;
    });
  }

  void onEnd() {
    setState(() {
      _top = min(max(_top, 0), height);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double top = min(max(_top, 0), height);
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: top,
              color: Colors.green,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: top,
            bottom: 0,
            child: Container(
              height: double.infinity,
              color: Colors.grey,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: top,
            bottom: 0,
            child: ElSplitResizerTheme(
              data: ElSplitResizerThemeData(
                axis: Axis.horizontal,
                // 避免匿名函数，否则每次 build 主题对象将不一致，
                // 造成分割器 Overlay 不断删除、插入
                onChanged: onChanged,
                onEnd: onEnd,
              ),
              child: const ElSplitResizer(),
            ),
          ),
        ],
      ),
    );
  }
}''';
