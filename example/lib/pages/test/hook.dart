import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HookTestPage extends HookWidget {
  const HookTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook 测试页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            count.value++;
          },
          child: Text('count: ${count.value}'),
        ),
      ),
    );
  }
}
