import 'package:element_docs/global.dart';
import 'package:element_docs/pages/test/temp_test_page.dart';
import 'package:flutter/material.dart';

import '../../commons/component/basic/button/index.dart';

class ScrollRenderTestPage extends HookWidget {
  const ScrollRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(
      builder: (context) => TempTestPage.tempSwitch.value
          ? const SingleChildScrollView(
              child: RepaintBoundary(child: _Child()),
            )
          : const ScrollWidget(
              child: RepaintBoundary(child: _Child2()),
            ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ...List.generate(
            3000,
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
      // height: 820000,
      child: Column(
        children: [
          ...buttonPage.buildPage(context),
          // ...List.generate(
          //   3000,
          //   (index) => Text('列表 - ${index + 1}'),
          // ),
        ],
      ),
    );
  }
}

