import 'package:example/global.dart';
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
          child: '默认消息(局部)',
        ),
        ElButton(
          onPressed: () {
            el.message.success('恭喜你，这是一条成功消息');
          },
          type: 'success',
          child: '成功',
        ),
        ElButton(
          onPressed: () {
            el.message.info('这是一条消息提示');
          },
          type: 'info',
          child: '消息',
        ),
        ElButton(
          onPressed: () {
            el.message.warning('警告哦，这是一条警告消息');
          },
          type: 'warning',
          child: '警告',
        ),
        ElButton(
          onPressed: () {
            for (int i = 0; i < 100; i++) {
              el.message.error('错了哦，这是一条错误消息');
            }
          },
          type: 'error',
          child: '错误',
        ),
      ],
    );
  }
}
