import 'package:defer_pointer/defer_pointer.dart';
import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayoutDragPage extends StatefulWidget {
  const LayoutDragPage({super.key});

  @override
  State<LayoutDragPage> createState() => _LayoutDragPageState();
}

class _LayoutDragPageState extends State<LayoutDragPage> {
  double left = 200;
  double splitSize = 0;
  double splitTriggerSize = 8;
  bool isStartDrag = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: left,
              color: Colors.purple,
            ),
            Container(
              width: splitSize,
              color: Colors.red,
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: left - (splitTriggerSize - splitSize) / 2,
          child: GestureDetector(
            onHorizontalDragStart: (e) {
              setState(() {
                isStartDrag = true;
              });
            },
            onHorizontalDragUpdate: (e) {
              if (isStartDrag) {
                i(e);
                setState(() {
                  left += e.delta.dx;
                });
              }
            },
            onHorizontalDragEnd: (e) {
              setState(() {
                isStartDrag = false;
              });
            },
            onHorizontalDragCancel: () {
              setState(() {
                isStartDrag = false;
              });
            },
            child: HoverBuilder(
              cursor: SystemMouseCursors.resizeColumn,
              onlyCursor: true,
              builder: (context) {
                return Stack(
                  children: [
                    SizedBox(width: splitTriggerSize),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left:
                          isStartDrag ? 0 : (splitTriggerSize - splitSize) / 2,
                      right:
                          isStartDrag ? 0 : (splitTriggerSize - splitSize) / 2,
                      top: 0,
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isStartDrag ? splitTriggerSize : splitSize,
                        decoration: BoxDecoration(
                          color: isStartDrag ? Colors.cyan : null,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );

    // return Row(
    //   children: [
    //     Container(
    //       width: 200,
    //       color: Colors.purple,
    //     ),
    //     Stack(
    //       clipBehavior: Clip.none,
    //       children: [
    //         Container(
    //           width: 0,
    //           height: double.infinity,
    //           color: Colors.green,
    //         ),
    //         Positioned(
    //           top: 0,
    //           bottom: 0,
    //           // left: -20,
    //           right: -20,
    //           child: GestureDetector(
    //             behavior: HitTestBehavior.translucent,
    //             onTap: () {
    //               i('click');
    //             },
    //             child: Container(
    //               width: 40,
    //               // height: double.infinity,
    //               decoration: BoxDecoration(
    //                 // color: Colors.red,
    //                 border: Border.all(),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     Expanded(
    //       child: Container(
    //         // width: double.infinity,
    //         // height: double.infinity,
    //         color: Colors.grey,
    //       ),
    //     ),
    //   ],
    // );

    // return const Padding(
    //   padding: EdgeInsets.all(8.0),
    //   child: ElLayout(
    //     children: [
    //       ElAside(
    //         child: SizedBox(
    //           width: 240,
    //           child: Text('Aside'),
    //         ),
    //       ),
    //       ElSplit(),
    //       ElLayout(
    //         children: [
    //           ElHeader(child: Text('Header')),
    //           // ElSplit(),
    //           ElMain(child: Text('Main')),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
