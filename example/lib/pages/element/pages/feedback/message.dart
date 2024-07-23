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
        children: [
          ElButton(
            onPressed: () {
              $el.showMessage(context, content: '这是一条消息提示');
            },
            child: '默认消息',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage(
                $el.context,
                content: '恭喜你，这是一条成功消息',
                type: 'success',
                showClose: true,
              );
            },
            type: 'success',
            child: '成功',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage(
                $el.context,
                content: '这是一条消息提示',
                type: 'info',
                // duration: 1000 * 60,
                showClose: true,
              );
            },
            type: 'info',
            child: '消息',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage($el.context,
                  content: '警告哦，这是一条警告消息', type: 'warning');
            },
            type: 'warning',
            child: '警告',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage($el.context,
                  content: '错了哦，这是一条错误消息', type: 'error');
            },
            type: 'error',
            child: '错误',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage($el.context,
                  content: '恭喜你，这是一条成功消息', type: 'success', grouping: true);
            },
            type: 'success',
            child: '合并相同类型消息',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage($el.context,
                  content: '错了哦，这是一条错误消息', type: 'error', grouping: true);
            },
            type: 'error',
            child: '合并相同类型消息',
          ),
          ElButton(
            onPressed: () {
              $el.showMessage(
                $el.context,
                content: 'xxxxxxxxxxxxxxx' * 10,
                type: 'primary',
                offset: 50,
                showClose: true,
              );
            },
            type: 'primary',
            child: '长消息',
          ),
          ElButton(
            onPressed: () {
              int num = Random().nextInt(10000);
              $el.showMessage(
                $el.context,
                builder: (context, message) => ElevatedButton(
                  onPressed: () {
                    message.removeMessage();
                    $el.showToast(context, '您移除了自定义消息 - $num');
                  },
                  child: Text('自定义消息：$num'),
                ),
                type: 'warning',
              );
            },
            child: '自定义消息内容',
          ),
        ],
      ),
    );
  }
}
