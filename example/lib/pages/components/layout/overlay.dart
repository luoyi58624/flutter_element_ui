import 'package:defer_pointer/defer_pointer.dart';
import 'package:example/global.dart';
import 'package:flutter/material.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: SizedBox(
        width: 500,
        height: 100,
        child: Row(
          children: [
            Container(
              width: 50,
              alignment: Alignment.centerRight,
              color: Colors.purple,
              child: const Text('demo'),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.yellow,
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: -5,
                  right: -5,
                  child: DeferPointer(
                    paintOnTop: true,
                    child: HoverBuilder(builder: (isHover) {
                      return Container(
                        width: 10,
                        color: Colors.cyan,
                      );
                    }),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: const Text('hello'),
              ),
            ),
            Expanded(flex: 2, child: Container(color: Colors.grey)),
            Container(width: 50, color: Colors.purple),
            Expanded(child: Container(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
