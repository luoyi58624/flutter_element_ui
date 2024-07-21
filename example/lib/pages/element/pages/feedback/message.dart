import 'package:example/global.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElButton(
            onPressed: () {
              $el.showMessage(context, '消息 - $count');
              count++;
            },
            child: 'default message',
          ),
          ...$el.themeTypes.map(
            (type) => ElButton(
              onPressed: () {
                $el.showToast(context, '$type toast', type: type);
              },
              type: type,
              child:
                  '${type.substring(0, 1).toUpperCase() + type.substring(1)} Message',
            ),
          ),
          // 自定义 toast 使用全局 context，它的层级非常高
          // ElButton(
          //   onPressed: () {
          //     $el.showToast(
          //       $el.overlayContext,
          //       'Custom Toast',
          //       builder: (content) => _CustomToast(content),
          //     );
          //   },
          //   child: 'Custom Toast',
          // ),
          const ElInput(),
        ],
      ),
    );
  }
}
