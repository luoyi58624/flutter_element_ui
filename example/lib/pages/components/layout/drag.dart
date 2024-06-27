import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayoutDragPage extends StatelessWidget {
  const LayoutDragPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 0,
          height: 0,
          color: Colors.green,
        ),
        Positioned(
          top: 10,
          left: 100,
          child: GestureDetector(
            onTap: () {
              i('click');
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
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
