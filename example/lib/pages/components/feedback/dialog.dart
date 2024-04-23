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
            '确认提示框',
            onPressed: () {
              ElDialog.showConfirm(
                context,
                '警告',
                '你确定要删除吗？',
                confirmButtonType: ElThemeType.error,
                confirmLoadingText: '删除中...',
                onConfirm: () async {},
              );
            },
          ),
          const SizedBox(height: 8),
          ElButton(
            '弹出Dialog',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ElDialog(
                  title: 'Dialog标题',
                  footer: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElButton(
                        '取消',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      ElButton(
                        '确定',
                        type: ElThemeType.primary,
                        onPressed: () {},
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
