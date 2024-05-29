import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_getx/mini_getx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElButton(
            'hello, 你好呀',
            onPressed: () {},
          ),
          // Obx(
          //   () => ElButton(
          //     GlobalController.of.useDark.value ? '开启亮色模式' : '开启黑暗模式',
          //     onPressed: () {
          //       GlobalController.of.useDark.value = !GlobalController.of.useDark.value;
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
