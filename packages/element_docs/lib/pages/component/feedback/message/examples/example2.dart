import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElButton(
          onPressed: () {
            el.message.show('这是一条消息提示', grouping: true);
          },
          type: El.info,
          child: '默认',
        ),
        ElButton(
          onPressed: () {
            el.message.show('这是一条消息提示', type: El.primary, grouping: true);
          },
          type: El.primary,
          child: '主要',
        ),
        ElButton(
          onPressed: () {
            el.message.show('恭喜你，这是一条成功消息', type: El.success, grouping: true);
          },
          type: El.success,
          child: '成功',
        ),
        ElButton(
          onPressed: () {
            el.message.show('警告哦，这是一条警告消息', type: El.warning, grouping: true);
          },
          type: El.warning,
          child: '警告',
        ),
        ElButton(
          onPressed: () {
            for (int i = 0; i < 10; i++) {
              el.message.show('错了哦，这是一条错误消息', type: El.error, grouping: true);
            }
          },
          type: El.error,
          child: '错误',
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElButton(
          onPressed: () {
            el.message.show('这是一条消息提示', grouping: true);
          },
          type: El.info,
          child: '默认',
        ),
        ElButton(
          onPressed: () {
            el.message.show('这是一条消息提示', type: El.primary, grouping: true);
          },
          type: El.primary,
          child: '主要',
        ),
        ElButton(
          onPressed: () {
            el.message.show('恭喜你，这是一条成功消息', type: El.success, grouping: true);
          },
          type: El.success,
          child: '成功',
        ),
        ElButton(
          onPressed: () {
            el.message.show('警告哦，这是一条警告消息', type: El.warning, grouping: true);
          },
          type: El.warning,
          child: '警告',
        ),
        ElButton(
          onPressed: () {
            for (int i = 0; i < 10; i++) {
              el.message.show('错了哦，这是一条错误消息', type: El.error, grouping: true);
            }
          },
          type: El.error,
          child: '错误',
        ),
      ],
    );
  }
}''';
