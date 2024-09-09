import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class ThemePage extends ResponsivePage {
  const ThemePage({super.key});

  @override
  String get title => '主题';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      ElButton(
        onPressed: () {
          el.context.push(_ChildPage());
        },
        child: '下一页',
      ),
      Container(
        width: 50,
        height: 50,
        color: el.context.isDark ? Colors.red : Colors.green,
      ),
    ];
  }
}

class _ChildPage extends StatelessWidget {
  const _ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          ObsBuilder(builder: (context) {
            return IconButton(
              tooltip: GlobalState.isDark ? '切换亮色模式' : '切换黑暗模式',
              onPressed: () {
                GlobalState.isDark = !GlobalState.isDark;
              },
              icon: Icon(
                GlobalState.isDark ? Icons.dark_mode : Icons.light_mode,
              ),
              color: context.elTheme.iconStyle.color,
            );
          }),
        ],
      ),
      body: Column(
        children: [
          ElText(
            context.globalFontSize,
            style: TextStyle(fontSize: 1.rem(context)),
          ),
          ObsBuilder(builder: (context) {
            return Slider(
              min: 8,
              max: 36,
              label: GlobalState.globalFontSize.value
                  .toStringAsFixed(2)
                  .toString(),
              value: GlobalState.globalFontSize.value,
              onChanged: (v) => GlobalState.globalFontSize.value = v,
            );
          }),
        ],
      ),
    );
  }
}
