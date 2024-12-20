import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

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

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onCancel: () {
            el.message.error('取消');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击'),
          ),
        ),
        ElEvent(
          onSecondaryTap: () {
            el.message.primary('右键');
          },
          onCancel: () {
            el.message.error('取消');
          },
          prevent: true,
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('右键'),
          ),
        ),
        ElEvent(
          onDoubleTap: () {
            el.message.success('双击');
          },
          onCancel: () {
            el.message.error('取消');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onDoubleTap: () {
            el.message.success('双击');
          },
          onCancel: () {
            el.message.error('取消');
          },
          child: Container(
            width: 120,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击 + 双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onDoubleTap: () {
            el.message.success('双击');
          },
          onCancel: () {
            el.message.error('取消');
          },
          delayTapForDouble: true, // 这个功能是 GestureDetector 小部件默认逻辑
          child: Container(
            width: 160,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('延迟单击 + 双击'),
          ),
        ),
        ElEvent(
          onLongPress: () {
            el.message.warning('长按');
          },
          onCancel: () {
            el.message.error('取消');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('长按'),
          ),
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击'),
          ),
        ),
        ElEvent(
          onSecondaryTap: () {
            el.message.primary('右键');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('右键'),
          ),
        ),
        ElEvent(
          onDoubleTap: () {
            el.message.success('双击');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onDoubleTap: () {
            el.message.success('双击');
          },
          child: Container(
            width: 120,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击 + 双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onDoubleTap: () {
            el.message.success('双击');
          },
          delayTapForDouble: true, // 这个功能是 GestureDetector 小部件默认逻辑
          child: Container(
            width: 160,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('延迟单击 + 双击'),
          ),
        ),
        ElEvent(
          onLongPress: () {
            el.message.warning('长按');
          },
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('长按'),
          ),
        ),
      ],
    );
  }
}''';
