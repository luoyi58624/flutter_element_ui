import 'package:defer_pointer/defer_pointer.dart';
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
    return const ElSplitLayout(
      children: [
        SidebarWidget(),
        ElSplitResizer(size: 1),
        SidebarWidget(),
        ElSplitResizer(),
        MainWidget(),
        ElSplitResizer(),
        SidebarWidget(),
      ],
    );
  }
}

class SidebarWidget extends ElSplitLayoutWidget {
  const SidebarWidget({super.key, super.size = 200});

  @override
  Widget build(BuildContext context) {
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

class MainWidget extends ElSplitLayoutWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}
