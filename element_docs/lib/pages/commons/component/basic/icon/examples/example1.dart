import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'test.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code1,
          expanded: true,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              children: [
                const ElIcon(ElIcons.sHome),
                const ElIcon(ElIcons.edit),
                const ElIcon(ElIcons.share),
                const ElIcon(ElIcons.delete),
                const ElButton(
                  type: 'primary',
                  leftIcon: ElIcon(ElIcons.search),
                  child: '搜索',
                ),
                ElButton(
                  onPressed: () {},
                  type: 'primary',
                  rightIcon: const ElIcon(ElIcons.upload2),
                  child: '上传',
                ),
                // ElButton(
                //   onPressed: () {
                //     context.push(const IconTestPage());
                //   },
                //   type: 'primary',
                //   child: '图标列表',
                // ),
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
