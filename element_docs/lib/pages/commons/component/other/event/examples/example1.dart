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
          child: Container(
            width: 100,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('单击'),
          ),
        ),
        ElEvent(
          onContextMenu: () {
            el.message.show('右键单击');
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
            el.message.show('双击');
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
            el.message.show('双击');
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
            el.message.show('双击');
          },
          onCancel: () {
            el.message.show('取消', type: El.error);
          },
          delayTapForDouble: true,
          child: Container(
            width: 160,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('延迟单击 + 双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onLongPress: () {
            el.message.show('长按');
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
          onContextMenu: () {
            el.message.show('右键单击');
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
            el.message.show('双击');
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
            el.message.show('双击');
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
            el.message.show('双击');
          },
          onCancel: () {
            el.message.show('取消', type: El.error);
          },
          delayTapForDouble: true,
          child: Container(
            width: 160,
            height: 50,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const ElText('延迟单击 + 双击'),
          ),
        ),
        ElEvent(
          onTap: () {
            el.message.show('单击');
          },
          onLongPress: () {
            el.message.show('长按');
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
