import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:example/global.dart';
import 'package:flutter/material.dart';

class OverlayPage extends HookWidget {
  const OverlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay测试'),
      ),
      body: Overlay(initialEntries: [
        OverlayEntry(
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  25,
                  (index) => CellWidget(title: '列表 - ${index + 1}'),
                ),
                const _OverlayWidget(),
                ...List.generate(
                  20,
                  (index) => CellWidget(title: '列表 - ${index + 1}'),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class _OverlayWidget extends StatefulWidget {
  const _OverlayWidget();

  @override
  State<_OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<_OverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return ElTooltip(
      content: const ElText('hello'),
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('插入 Overlay'),
      ),
    );
  }
}
