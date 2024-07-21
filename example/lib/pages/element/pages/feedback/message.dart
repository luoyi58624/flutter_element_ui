import 'package:example/global.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElButton(
              onPressed: () {
                $el.showMessage($el.context, '消息 - $count');
                count++;
              },
              child: 'default message',
            ),
            ElButton(
              onPressed: () {
                $el.showMessage($el.context, '恭喜你，这是一条成功消息', type: 'success');
              },
              child: '成功',
            ),
            ...$el.themeTypes.map(
              (type) => ElButton(
                onPressed: () {
                  $el.showMessage($el.context, '$type toast', type: type);
                },
                type: type,
                child:
                    '${type.substring(0, 1).toUpperCase() + type.substring(1)} Message',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
