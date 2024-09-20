import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('使用方法'),
        CodeExample(
          code: code1,
          children: const [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              children: [
                ElIcon(ElIcons.sHome),
                ElIcon(ElIcons.edit),
                ElIcon(ElIcons.share),
                ElIcon(ElIcons.delete),
                ElButton(
                  type: 'primary',
                  leftIcon: ElIcon(ElIcons.search),
                  child: '搜索',
                ),
                ElButton(
                  type: 'primary',
                  rightIcon: ElIcon(ElIcons.upload2),
                  child: '上传',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

String get code1 => '''
Wrap(
  crossAxisAlignment: WrapCrossAlignment.center,
  spacing: 16,
  children: [
    ElIcon(ElIcons.sHome),
    ElIcon(ElIcons.edit),
    ElIcon(ElIcons.share),
    ElIcon(ElIcons.delete),
    ElButton(
      type: 'primary',
      margin: EdgeInsets.zero,
      leftIcon: ElIcon(ElIcons.search),
      child: '搜索',
    ),
    ElButton(
      type: 'primary',
      margin: EdgeInsets.zero,
      rightIcon: ElIcon(ElIcons.upload2),
      child: '上传',
    ),
  ],
),''';
