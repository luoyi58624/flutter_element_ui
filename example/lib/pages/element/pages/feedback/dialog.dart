import 'package:example/global.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 8),
          ElButton(
            child: '确认提示框',
            onPressed: () {
              ElDialog.showConfirm(
                context,
                '警告',
                '你确定要删除吗？',
                confirmButtonType: 'error',
                confirmLoadingText: '删除中...',
                onConfirm: () async {
                  await Future.delayed(const Duration(seconds: 2));
                },
              );
            },
          ),
          const SizedBox(height: 8),
          ElButton(
            child: '弹出Dialog',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ElDialog(
                  title: 'Dialog标题',
                  footer: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElButton(
                        child: '取消',
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      const SizedBox(width: 8),
                      ElButton(
                        child: '确定',
                        onPressed: () {
                          context.pop();
                        },
                        type: 'primary',
                      ),
                    ],
                  ),
                  child: const Text('hello'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
