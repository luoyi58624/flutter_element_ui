import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

const _buttonTypes = [null, ...El.themeTypes];

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
          code: code,
          expanded: true,
          children: const [
            _Example(),
            Gap(8),
            _Example1(),
            Gap(8),
            _Example2(),
            Gap(8),
            _Example3(),
            Gap(8),
            _Example4(),
            Gap(8),
            _Example5(),
            Gap(8),
            _Example6(),
            Gap(8),
            _Example7(),
            Gap(8),
            _Example8(),
            Gap(8),
            _Example9(),
            Gap(8),
            _Example10(),
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
      children: _buttonTypes
          .map((type) => ElButton2(type: type, child: 'Hello'))
          .toList(),
    );
  }
}

const _customColorList = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.cyan,
  Colors.blue,
  Colors.purple,
];

class _Example1 extends StatelessWidget {
  const _Example1();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _customColorList
          .map((color) => ElButton2(bgColor: color, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElOutlineButton(type: type, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example3 extends StatelessWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) =>
              ElOutlineButton(type: type, plain: false, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example4 extends StatelessWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElOutlineButton(
              type: type, onlyActiveBorder: true, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example5 extends StatelessWidget {
  const _Example5();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElOutlineButton(
              type: type, plain: false, onlyActiveBorder: true, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example6 extends StatelessWidget {
  const _Example6();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElTextButton(type: type, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example7 extends StatelessWidget {
  const _Example7();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElTextButton(type: type, bg: true, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example8 extends StatelessWidget {
  const _Example8();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElButton2(type: type, round: true, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example9 extends StatelessWidget {
  const _Example9();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) =>
              ElOutlineButton(type: type, round: true, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example10 extends StatelessWidget {
  const _Example10();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElTextButton(type: type, round: true, child: 'Hello'))
          .toList(),
    );
  }
}

String get code => '''
ElButton(child: 'Hello'), // 默认按钮
ElButton(child: 'Hello', type: El.primary), // 设置按钮主题
ElButton(child: 'Hello', bgColor: Colors.red), // 自定义颜色
ElOutlineButton(child: 'Hello'), // 边框按钮
ElOutlineButton(child: 'Hello', plain: false), // 将 plain 设为 false 按钮将移除微弱的背景装饰，同时移除 tap 反馈
ElOutlineButton(child: 'Hello', onlyActiveBorder: true), // 只激活边框，不改变背景
ElOutlineButton(child: 'Hello', plain: false, onlyActiveBorder: true),
ElTextButton(child: 'Hello'),
ElTextButton(child: 'Hello', bg: true),
ElButton(child: 'Hello', round: true), // 圆角按钮''';
