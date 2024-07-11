import 'package:example/global.dart';
import 'package:flutter/material.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  @override
  Widget build(BuildContext context) {
    return layout3();
  }

  Widget layout1() {
    return const ElSplitPanel(children: [
      SidebarWidget(),
      MainWidget(),
    ]);
  }

  Widget layout2() {
    return const ElSplitPanel(children: [
      SidebarWidget(),
      ElSplitResizer(size: 1),
      MainWidget(),
    ]);
  }

  Widget layout3() {
    return const ElSplitPanel(children: [
      SidebarWidget(),
      ElSplitResizer(
        position: ElSplitResizerPosition.right,
      ),
      ElSplitPanel(
        axis: Axis.vertical,
        children: [
          HeaderWidget(),
          ElSplitResizer(),
          MainWidget(),
        ],
      ),
    ]);
  }

  Widget layout4() {
    return const ElSplitPanel(children: [
      SidebarWidget(),
      ElSplitResizer(size: 1),
      ElSplitPanel(
        axis: Axis.vertical,
        children: [
          HeaderWidget(),
          ElSplitResizer(size: 1),
          ElSplitPanel(
            axis: Axis.vertical,
            children: [
              MainWidget(),
              ElSplitResizer(size: 1),
              MainWidget(),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget layout5() {
    return const ElSplitPanel(
      axis: Axis.vertical,
      children: [
        HeaderWidget(),
        ElSplitResizer(),
        ElSplitPanel(children: [
          ElSplitPanel(
            axis: Axis.vertical,
            children: [
              MainWidget(),
              ElSplitResizer(size: 1),
              MainWidget(),
            ],
          ),
          ElSplitResizer(size: 1),
          MainWidget(),
          ElSplitResizer(size: 1),
          ElSplitPanel(children: [
            MainWidget(),
            ElSplitResizer(size: 1),
            MainWidget(),
          ]),
        ]),
        ElSplitResizer(size: 1),
        FooterWidget(),
      ],
    );
  }
}

class HeaderWidget extends ElSplitSizePanel {
  const HeaderWidget({
    super.key,
    super.size = 56,
    super.minSize = 56,
    super.maxSize = 72,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: const Text('Header'),
    );
  }
}

class FooterWidget extends ElSplitSizePanel {
  const FooterWidget({super.key, super.size = 56});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: const Text('Footer'),
    );
  }
}

class SidebarWidget extends ElSplitSizePanel {
  const SidebarWidget({
    super.key,
    super.size = 200,
    super.minSize = 150,
  });

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.green,
    //   child: const Text('Sidebar'),
    // );
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          100,
          (index) => ElButton(
            onPressed: () {},
            child: '按钮 - ${index + 1}',
          ),
        ),
      ),
    );
  }
}

class MainWidget extends ElSplitFlexPanel {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      color: Colors.grey,
      child: const Text('Main'),
    );
  }
}
