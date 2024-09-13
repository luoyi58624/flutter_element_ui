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
                  (index) => CellWidget(
                    title: '列表 - ${index + 1}',
                    onTap: () {},
                  ),
                ),
                const _OverlayWidget(),
                ...List.generate(
                  20,
                  (index) => CellWidget(
                    title: '列表 - ${index + 1}',
                    onTap: () {},
                  ),
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
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return ElTooltip(
      // content: 'hello，this is a tooltip test2',
      content: flag
          ? 'hello，this is a tooltip test2'
          : Material(
              child: SizedBox(
                width: 300,
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        100,
                        (index) => CellWidget(
                          title: '列表- ${index + 1}',
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      selected: true,
      bgColor: context.elTheme.colors.border.deepen(10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            flag = !flag;
          });
        },
        child: const Text('插入 Overlay'),
      ),
    );
  }
}
