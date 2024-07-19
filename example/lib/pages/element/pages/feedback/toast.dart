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
              $el.showToast(context, 'default toast');
            },
            child: 'Toast',
          ),
          ...$el.themeTypes.map(
            (type) => ElButton(
              onPressed: () {
                $el.showToast(context, '$type toast', type: type);
              },
              type: type,
              child:
                  '${type.substring(0, 1).toUpperCase() + type.substring(1)} Toast',
            ),
          ),
          // 自定义 toast 使用全局 context，它的层级非常高
          ElButton(
            onPressed: () {
              $el.showToast(
                $el.overlayContext,
                'Custom Toast',
                builder: (content) => _CustomToast(content),
              );
            },
            child: 'Custom Toast',
          ),
          const ElInput(),
        ],
      ),
    );
  }
}

/// 自定义 Toast 样式
class _CustomToast extends StatelessWidget {
  const _CustomToast(this.content);

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          $el.removeToast();
        },
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(colors: [
              Colors.blue,
              Colors.purple,
            ]),
          ),
          child: Center(
            child: Text(
              '$content',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
