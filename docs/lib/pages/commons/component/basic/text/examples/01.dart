import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H1('一级标题 (H1)'),
        H2('二级标题 (H2)'),
        H3('三级标题 (H3)'),
        H4('四级标题 (H4)'),
        H5('五级标题 (H5)'),
        H6('六级标题 (H6)'),
        ElText('普通文本 (ElText)'),
      ],
    );
  }
}
