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
          if (PlatformUtil.isMobile)
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
          ObsBuilder(builder: (context) {
            return CellWidget(
              title: '监控 FPS 帧率',
              value: GlobalState.fps.value,
              onChanged: (v) {
                GlobalState.fps.value = v;
              },
            );
          }),
          CellWidget(
            title: '清除本地缓存',
            trailing: const SizedBox(),
            onTap: () async {
              await sp.clear();
              FlutterUtil.refreshApp();
              el.message.success('清除成功');
            },
          ),
        ],
      ),
    );
  }
}
