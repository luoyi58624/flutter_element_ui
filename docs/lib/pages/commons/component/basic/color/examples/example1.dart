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
        Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: context.elTheme.cardStyle.radius
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: context.elTheme.primary
                ),
              ),
              Row(
                children: [

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
