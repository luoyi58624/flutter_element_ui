import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example2 extends StatelessWidget {
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

const _customColorMap = {
  '红': Colors.red,
  '橙': Colors.orange,
  '黄': Colors.yellow,
  '绿': Colors.green,
  '青': Colors.cyan,
  '蓝': Colors.blue,
  '紫': Colors.purple
};

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _customColorMap.keys
          .map((key) => ElButton2(bgColor: _customColorMap[key], child: key))
          .toList(),
    );
  }
}

String get code => '''
const _customColorMap = {
  '红': Colors.red,
  '橙': Colors.orange,
  '黄': Colors.yellow,
  '绿': Colors.green,
  '青': Colors.cyan,
  '蓝': Colors.blue,
  '紫': Colors.purple
};

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _customColorMap.keys
          .map((key) => ElButton2(bgColor: _customColorMap[key], child: key))
          .toList(),
    );
  }
}''';
