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
          ...$el.themeTypes.map(
            (type) => ElButton(
              onPressed: () {
                $el.showToast('$type toast', type: type);
              },
              type: type,
              child:
                  '${type.substring(0, 1).toUpperCase() + type.substring(1)} Toast',
            ),
          ),
          const ElInput(),
        ],
      ),
    );
  }
}
