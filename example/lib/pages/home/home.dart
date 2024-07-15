import 'package:example/extensions/int.dart';
import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElSwitch(
              value: flag.value,
              onChanged: (v) => flag.value = v,
            ),
            // Overlay(),
          ],
        ),
      ),
    );
  }
}
