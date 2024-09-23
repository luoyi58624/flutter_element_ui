import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      GestureDetector(
        onTapDown: (e) {
          i('red');
        },
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.red,
              child: Center(
                child: GestureDetector(
                  onTapDown: (e) {
                    i('green');
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            // Positioned.fill(
            //   child: Center(
            //     child: GestureDetector(
            //       onTapDown: (e) {
            //         i('green');
            //       },
            //       child: Container(
            //         width: 100,
            //         height: 100,
            //         color: Colors.green,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ];
  }
}
