import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';

import 'large_title.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CupertinoButton(
            onPressed: () {
              context.push(const CupertinoLargeTitlePage());
            },
            child: const Text('按钮'),
          ),
          const Gap(8),
          CupertinoButton.filled(
            onPressed: () {},
            child: const Text('按钮'),
          ),
        ],
      ),
    );
  }
}
