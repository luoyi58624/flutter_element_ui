import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import '../../store.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1280,
        ),
        child: Column(
          children: [
            const Text('Overview 组件总览'),
            ValueListenableBuilder(
              valueListenable: GlobalStore.counter,
              builder: (context, value, _) => ElButton(
                'count: ${GlobalStore.counter.value}',
                onPressed: () {
                  GlobalStore.counter.value++;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
