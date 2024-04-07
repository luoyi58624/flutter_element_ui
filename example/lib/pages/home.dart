import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => ElButton(
                GlobalController.of.useDark.value ? '开启亮色模式' : '开启黑暗模式',
                onPressed: () {
                  GlobalController.of.useDark.value = !GlobalController.of.useDark.value;
                },
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                GlobalController.of.useDark.value = !GlobalController.of.useDark.value;
              },
              child: Text(GlobalController.of.useDark.value ? '开启亮色模式' : '开启黑暗模式'),
            ),
            const SizedBox(width: 8),
            CupertinoButton.filled(
              child: const Text('Hello'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
