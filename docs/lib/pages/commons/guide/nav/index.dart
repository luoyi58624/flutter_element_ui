import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      Stack(
        children: [
          Container(
            width: 300,
            height: 300,
            // color: Colors.white,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                color: context.elTheme.colors.borderLighter,
                // color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
