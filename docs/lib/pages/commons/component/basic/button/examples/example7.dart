import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example7 extends StatelessWidget {
  const Example7({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExampleWidget(
          code: code,
          children: const [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(child: '红', bgColor: Colors.red),
                ElButton(child: '橙', bgColor: Colors.orange),
                ElButton(child: '黄', bgColor: Colors.yellow),
                ElButton(child: '绿', bgColor: Colors.green),
                ElButton(child: '青', bgColor: Colors.cyan),
                ElButton(child: '蓝', bgColor: Colors.blue),
                ElButton(child: '紫', bgColor: Colors.purple),
              ],
            ),
            Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(child: '红', bgColor: Colors.red, plain: true),
                ElButton(child: '橙', bgColor: Colors.orange, plain: true),
                ElButton(child: '黄', bgColor: Colors.yellow, plain: true),
                ElButton(child: '绿', bgColor: Colors.green, plain: true),
                ElButton(child: '青', bgColor: Colors.cyan, plain: true),
                ElButton(child: '蓝', bgColor: Colors.blue, plain: true),
                ElButton(child: '紫', bgColor: Colors.purple, plain: true),
              ],
            ),
            Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(child: '红', bgColor: Colors.red, disabled: true),
                ElButton(child: '橙', bgColor: Colors.orange, disabled: true),
                ElButton(child: '黄', bgColor: Colors.yellow, disabled: true),
                ElButton(child: '绿', bgColor: Colors.green, disabled: true),
                ElButton(child: '青', bgColor: Colors.cyan, disabled: true),
                ElButton(child: '蓝', bgColor: Colors.blue, disabled: true),
                ElButton(child: '紫', bgColor: Colors.purple, disabled: true),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    ElButton(child: '红', bgColor: Colors.red),
    ElButton(child: '橙', bgColor: Colors.orange),
    ElButton(child: '黄', bgColor: Colors.yellow),
    ElButton(child: '绿', bgColor: Colors.green),
    ElButton(child: '青', bgColor: Colors.cyan),
    ElButton(child: '蓝', bgColor: Colors.blue),
    ElButton(child: '紫', bgColor: Colors.purple),
  ],
),''';
