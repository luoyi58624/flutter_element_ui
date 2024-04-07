import 'package:chicago/chicago.dart';
import 'package:example/controller/global.dart';
import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import '../../state.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  OverlayPortalController overlayPortalController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 640,
          minWidth: 320,
        ),
        // color: Colors.green,
        child: Column(
          children: [
            // const SizedBox(height: 8),
            // fluent.Button(
            //   child: const Text('Standard Button'),
            //   onPressed: () => debugPrint('pressed button'),
            // ),
            // const SizedBox(height: 8),
            // fluent.FilledButton(
            //   child: const Text('Standard Button'),
            //   onPressed: () => debugPrint('pressed button'),
            // ),
            // const SizedBox(height: 8),
            // macos.PushButton(
            //   controlSize: macos.ControlSize.regular,
            //   onPressed: () {},
            //   child: const Text('Hello'),
            // ),
            const SizedBox(height: 8),
            // ElevatedButton(
            //   onPressed: () {
            //     overlayPortalController.toggle();
            //   },
            //   child: OverlayPortal(
            //     controller: overlayPortalController,
            //     overlayChildBuilder: (context) => const Positioned(
            //       top: 100,
            //       child: Text('hello'),
            //     ),
            //     child: const Text('显示弹窗'),
            //   ),
            // ),
            Obx(() => ElButton(
                  GlobalController.of.useDark.value ? '开启亮色模式' : '开启黑暗模式',
                  onPressed: () {
                    GlobalController.of.useDark.value = !GlobalController.of.useDark.value;
                  },
                )),
            const Text('Overview 组件总览'),
            ValueListenableBuilder(
              valueListenable: GlobalState.counter,
              builder: (context, value, _) => ElButton(
                'count: ${GlobalState.counter.value}',
                onPressed: () {
                  GlobalState.counter.value++;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
