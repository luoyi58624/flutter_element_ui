import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          if (context.sm)
            ObsBuilder(builder: (context) {
              return Switch(
                value: GlobalState.isDark.value,
                onChanged: (v) => GlobalState.isDark.value = v,
              );
            }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MouseRegion(
              onEnter: (e) {
                i(e);
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
