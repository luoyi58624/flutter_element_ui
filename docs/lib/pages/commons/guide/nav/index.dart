import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              Positioned(
                // left: -50,
                // top: 25,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                  // color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
