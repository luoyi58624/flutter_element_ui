import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_getx/mini_getx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElButton2('Default'),
              const Gap(4),
              ElButton2('Primary', type: ElThemeType.primary),
              const Gap(4),
              ElButton2('Success', type: ElThemeType.success),
              const Gap(4),
              ElButton2('Info', type: ElThemeType.info),
              const Gap(4),
              ElButton2('Warning', type: ElThemeType.warning),
              const Gap(4),
              ElButton2('Error', type: ElThemeType.error),
              const Gap(4),
              ElButton2(
                'count: $count',
                onClick: () {
                  setState(() {
                    count++;
                  });
                },
              ),
              // Obx(
              //   () => ElButton(
              //     GlobalController.of.useDark.value ? '开启亮色模式' : '开启黑暗模式',
              //     onPressed: () {
              //       GlobalController.of.useDark.value = !GlobalController.of.useDark.value;
              //     },
              //   ),
              // ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElButton2('Default', text: true),
              const Gap(4),
              ElButton2('Primary', type: ElThemeType.primary, text: true),
              const Gap(4),
              ElButton2('Success', type: ElThemeType.success, text: true),
              const Gap(4),
              ElButton2('Info', type: ElThemeType.info, text: true),
              const Gap(4),
              ElButton2('Warning', type: ElThemeType.warning, text: true),
              const Gap(4),
              ElButton2('Error', type: ElThemeType.error, text: true),
              const Gap(4),
            ],
          ),
        ],
      ),
    );
  }
}
