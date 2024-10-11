import 'package:example/global.dart';
import 'package:flutter/material.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            el.toast.show('default toast');
          },
          child: 'Toast',
        ),
        ...elThemeTypes.map(
              (type) => ElButton(
            onPressed: () {
              el.toast.show('$type toast', type: type);
            },
            type: type,
            child:
            '${type.substring(0, 1).toUpperCase() + type.substring(1)} Toast',
          ),
        ),
        ElButton(
          onPressed: () {
            el.toast.builder(
              'Custom Toast',
                  (content) => _CustomToast(content),
            );
          },
          child: 'Custom Toast',
        ),
        const ElInput(''),
      ],
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
          el.toast.remove();
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
