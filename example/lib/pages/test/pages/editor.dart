import 'package:example/global.dart';
import 'package:flutter/material.dart';

class EditorTestPage extends HookWidget {
  const EditorTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ElUtils.unFocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('编辑器测试'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ElEditor(),
        ),
      ),
    );
  }
}
