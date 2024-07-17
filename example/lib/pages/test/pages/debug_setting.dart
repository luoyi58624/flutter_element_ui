import 'package:example/global.dart';
import 'package:flutter/material.dart';

class DebugSettingPage extends StatelessWidget {
  const DebugSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug设置'),
      ),
      body: ColumnWidget(
        scroll: true,
        children: [
          ObsBuilder(builder: (context) {
            return CellWidget(
              title: '开启边界重绘',
              value: GlobalState.enabledRepaintRainbow.value,
              onChanged: (v) {
                GlobalState.enabledRepaintRainbow.value = v;
              },
            );
          }),
          ObsBuilder(builder: (context) {
            return CellWidget(
              title: '开启重采用',
              value: GlobalState.enableResampling.value,
              onChanged: (v) {
                GlobalState.enableResampling.value = v;
              },
            );
          }),
          ObsBuilder(builder: (context) {
            return CellWidget(
              title: '开启性能视图',
              value: GlobalState.showPerformanceOverlay.value,
              onChanged: (v) {
                GlobalState.showPerformanceOverlay.value = v;
              },
            );
          }),
        ],
      ),
    );
  }
}
