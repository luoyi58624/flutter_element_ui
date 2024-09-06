import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('主色'),
        const SectionText('Element UI 默认的主题色是明亮、友好的蓝色。'),
      ],
    );
  }
}
