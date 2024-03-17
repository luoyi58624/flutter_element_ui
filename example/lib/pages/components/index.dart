import 'dart:convert';

import 'package:example/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import '../../store.dart';

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
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                overlayPortalController.toggle();
              },
              child: OverlayPortal(
                controller: overlayPortalController,
                overlayChildBuilder: (context) => const Positioned(
                  top: 100,
                  child: Text('hello'),
                ),
                child: const Text('显示弹窗'),
              ),
            ),
            const Text('Overview 组件总览'),
            ValueListenableBuilder(
              valueListenable: GlobalStore.counter,
              builder: (context, value, _) => ElButton(
                'count: ${GlobalStore.counter.value}',
                onPressed: () {
                  GlobalStore.counter.value++;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
