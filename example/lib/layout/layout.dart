import 'package:example/layout/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('测试'),
    //   ),
    //   body: Column(
    //     children: [
    //       ElevatedButton(
    //         onPressed: () {
    //           setState(() {
    //             flag = !flag;
    //           });
    //         },
    //         child: Text('xx'),
    //       ),
    //       AnimatedCrossFade(
    //         firstChild: Container(
    //           height: 50.0,
    //           color: Colors.green,
    //         ),
    //         secondChild: Container(
    //           height: 100.0,
    //           color: Colors.green,
    //         ),
    //         firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
    //         secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
    //         sizeCurve: Curves.fastOutSlowIn,
    //         crossFadeState:
    //             flag ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    //         duration: const Duration(milliseconds: 300),
    //       ),
    //     ],
    //   ),
    // );
    return Row(
      children: [
        Sidebar(),
      ],
    );
  }
}
