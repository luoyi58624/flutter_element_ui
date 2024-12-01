import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            el.message.show('这是一条消息提示');
          },
          type: El.info,
          child: '默认',
        ),
        const Gap(8),
        ElButton(
          onPressed: () {
            el.message.show('这是一条消息提示', type: El.primary, closeDuration: 10.ss);
          },
          type: El.primary,
          child: '主要',
        ),
        const Gap(8),
        ElButton(
          onPressed: () {
            el.message.show('恭喜你，这是一条成功消息', type: El.success);
          },
          type: El.success,
          child: '成功',
        ),
        const Gap(8),
        ElButton(
          onPressed: () {
            el.message.show('警告哦，这是一条警告消息', type: El.warning);
          },
          type: El.warning,
          child: '警告',
        ),
        const Gap(8),
        ElButton(
          onPressed: () {
            for (int i = 0; i < 10; i++) {
              el.message.show('错了哦，这是一条错误消息', type: El.error);
            }
          },
          type: El.error,
          child: '错误',
        ),
      ],
    );
  }
}
