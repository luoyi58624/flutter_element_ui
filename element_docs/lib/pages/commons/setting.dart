import 'package:element_docs/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlobalSetting extends StatelessWidget {
  const GlobalSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Gap(16),
                H4('设置'),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
                  },
                  icon: const ElIcon(Icons.close),
                ),
                const Gap(8),
              ],
            ),
          ),
          const ElDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
                child: H5('全局主题动画时间'),
              ),
              ObsBuilder(builder: (context) {
                return Slider(
                  min: 0,
                  max: 5000,
                  label: GlobalState.themeDuration.value.round().toString(),
                  value: GlobalState.themeDuration.value,
                  onChanged: (v) => GlobalState.themeDuration.value = v,
                );
              }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
                child: H5('调整全局文本尺寸'),
              ),
              ObsBuilder(builder: (context) {
                return Slider(
                  min: 8,
                  max: 24,
                  label: GlobalState.globalFontSize.round().toString(),
                  value: GlobalState.globalFontSize,
                  onChanged: (v) => GlobalState.globalFontSize = v,
                );
              }),
            ],
          ),
          if (kDebugMode)
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
              title: '开启语义调式器',
              value: GlobalState.showSemanticsDebugger.value,
              onChanged: (v) {
                GlobalState.showSemanticsDebugger.value = v;
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
          if (kIsWeb == false)
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
