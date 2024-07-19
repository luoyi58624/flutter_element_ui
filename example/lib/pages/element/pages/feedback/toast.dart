import 'package:example/global.dart';
import 'package:flutter/material.dart';

class ToastPage extends HookWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElButton(
            onPressed: () {
              $el.showToast('default toast');
            },
            child: 'Toast',
          ),
          ElButton(
            onPressed: () {
              $el.showToast('default toast');
            },
            type: 'primary',
            child: 'Primary Toast',
          ),
        ],
      ),
    );
  }
}
