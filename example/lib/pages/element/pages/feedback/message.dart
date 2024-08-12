import 'dart:math';

import 'package:example/global.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElButton(
                  onPressed: () {
                    el.message.show('这是一条消息提示', context: context);
                  },
                  child: '默认消息(局部)',
                ),
                ElButton(
                  onPressed: () {
                    el.message.success('恭喜你，这是一条成功消息');
                  },
                  type: 'success',
                  child: '成功',
                ),
                ElButton(
                  onPressed: () {
                    el.message.info('这是一条消息提示');
                  },
                  type: 'info',
                  child: '消息',
                ),
                ElButton(
                  onPressed: () {
                    for (int i = 0; i < 3; i++) {
                      el.message.warning('警告哦，这是一条警告消息');
                    }
                  },
                  type: 'warning',
                  child: '警告',
                ),
                ElButton(
                  onPressed: () {
                    el.message.error('错了哦，这是一条错误消息');
                  },
                  type: 'error',
                  child: '错误',
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElButton(
                  onPressed: () {
                    el.message.success('恭喜你，这是一条成功消息', grouping: true);
                  },
                  type: 'success',
                  child: '合并相同类型消息',
                ),
                ElButton(
                  onPressed: () {
                    el.message.error('错了哦，这是一条错误消息', grouping: true);
                  },
                  type: 'error',
                  child: '合并相同类型消息',
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElButton(
                  onPressed: () {
                    el.message.primary('长文本消息' * 10, offset: 50);
                  },
                  type: 'primary',
                  child: '长消息',
                ),
                ElButton(
                  onPressed: () {
                    int num = Random().nextInt(10000);
                    el.message.show(
                      num.toString(),
                      builder: (context, message) => ElevatedButton(
                        onPressed: () {
                          message.removeMessage();
                          el.toast.show('您移除了自定义消息 - $num');
                        },
                        child: Text('自定义消息：$num'),
                      ),
                      type: 'warning',
                    );
                  },
                  child: '自定义消息内容',
                ),
                ElButton(
                  onPressed: () {
                    el.message.show(
                      '自定义消息',
                      builder: (context, message) => ElevatedButton(
                        onPressed: () {
                          message.removeMessage();
                          // message.
                        },
                        child: Text(message.content),
                      ),
                      grouping: true,
                    );
                  },
                  child: '自定义消息内容(合并)',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
