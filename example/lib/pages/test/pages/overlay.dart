import 'package:example/global.dart';
import 'package:flutter/material.dart';

class OverlayPage extends HookWidget {
  const OverlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LayerLink _link = LayerLink();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay测试'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              5,
              (index) => CellWidget(title: '列表 - ${index + 1}'),
            ),
            // CompositedTransformFollower(
            //   link: _link,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: Text('被链接的button'),
            //   ),
            // ),
            // CompositedTransformTarget(
            //   link: _link,
            //   child: Container(
            //     width: 100,
            //     height: 100,
            //     color: Colors.grey,
            //   ),
            // ),
            ...List.generate(
              5,
              (index) => CellWidget(title: '列表 - ${index + 1}'),
            ),
            CompositedTransformTarget(
              link: _link,
              child: ElevatedButton(
                onPressed: () {
                  OverlayEntry? entry;
                  entry = OverlayEntry(
                    builder: (BuildContext context) {
                      return UnconstrainedBox(
                        child: CompositedTransformFollower(
                          link: _link,
                          showWhenUnlinked: false,
                          targetAnchor: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (entry != null) {
                                entry.remove();
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  Overlay.of(context).insert(entry);
                },
                child: const Text('插入 Overlay'),
              ),
            ),
            ...List.generate(
              10,
              (index) => CellWidget(title: '列表 - ${index + 1}'),
            ),
          ],
        ),
      ),
    );
  }
}
