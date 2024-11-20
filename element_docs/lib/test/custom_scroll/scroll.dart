import 'package:element_docs/global.dart';
import 'package:element_docs/test/temp_test_page.dart';
import 'package:flutter/material.dart';

import '../../pages/component/basic/button/index.dart';

class ScrollRenderTestPage extends HookWidget {
  const ScrollRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return TempTestPage.tempSwitch.value
          ? const SingleChildScrollView(
              child: _Child(),
            )
          : const SingleChildScrollView(
              child: _Child2(),
            );
    });
  }
}

class _Child extends StatelessWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    const buttonPage = ButtonPage();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ...buttonPage.buildPage(context) * 1,
          ...List.generate(
            100,
            (index) => Text('列表 - ${index + 1}'),
          ),
        ],
      ),
    );
  }
}

class _Child2 extends StatelessWidget {
  const _Child2();

  @override
  Widget build(BuildContext context) {
    const buttonPage = ButtonPage();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ...buttonPage.buildPage(context) * 1,
          ...List.generate(
            100,
            (index) => Text('列表 - ${index + 1}'),
          ),
        ],
      ),
    );
  }
}
