import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            '确认提示框',
            onClick: () {
              ElDialog.showConfirm(
                context,
                '警告',
                '你确定要删除吗？',
                confirmButtonType: ElThemeType.error,
                confirmLoadingText: '删除中...',
                onConfirm: () async {
                  await Future.delayed(Duration(seconds: 2));
                  ElMessage.show('删除成功');
                },
              );
            },
          ),
          const SizedBox(height: 8),
          ElButton(
            '弹出Dialog',
            onClick: () {
              showDialog(
                context: context,
                builder: (context) => ElDialog(
                  title: 'Dialog标题',
                  footer: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElButton(
                        '取消',
                        onClick: () {
                          context.pop();
                        },
                      ),
                      const SizedBox(width: 8),
                      ElButton(
                        '确定',
                        onClick: () {
                          context.pop();
                        },
                        style: ElButtonStyle(
                          type: ElThemeType.primary,
                        ),
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
