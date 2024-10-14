import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class TempTestPage extends HookWidget {
  const TempTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('临时测试页面'),
      ),
      body: Row(
        children: [
          ...List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTapDown: (e) {
                  activeIndex.value = index;
                },
                child: Draggable(
                  onDragUpdate: (e){
                    i(e.delta.dx);
                  },
                  feedback: Container(
                    width: 100,
                    height: 44,
                    // color: Colors.green,
                  ),
                  child: Container(
                    width: 100,
                    height: 44,
                    decoration: BoxDecoration(
                      color: activeIndex.value == index ? Colors.red : null,
                      border: Border.all(color: context.elTheme.colors.border),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
