import 'dart:math';

import 'package:docs/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      // LinearProgressIndicator(),
      // ...List.generate(
      //   1,
      //   (index) => const ElProgress.animate(50),
      // )

      Click(
        onClick: () {
          el.e('first');
        },
        child: Container(
          width: 300,
          height: 300,
          color: Colors.grey,
          child: Click(
            onClick: () {
              el.i('parent');
            },
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
                child: Center(
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Click.stopPropagation(context);
                              el.w('child');
                            },
                            onTapDown: (e) {},
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.red,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              el.w('child');
                            },
                            onTapDown: (e) {},
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
