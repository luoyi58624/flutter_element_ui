import 'dart:ui';

import 'package:element_flutter/element_flutter.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElMenu extends StatelessWidget {
  /// Element UI 默认菜单样式
  const ElMenu({super.key});

  /// 创建自适应菜单，在不同平台上展示原生外观
  const ElMenu.adaptive({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14.0);
    return ElRing(
      show: true,
      offset: 0,
      width: 0.8,
      radius: radius,
      color: const Color.fromRGBO(183, 183, 183, 0.8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(36),
              offset: const Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: const Offset(0, 0),
              blurRadius: 14,
              spreadRadius: 0,
            ),
          ],
        ),
        child: CupertinoPopupSurface(
          child: SizedBox(
            width: 136,
            height: 100,
          ),
        ),
      ),
    );
    // return ElRing(
    //   show: true,
    //   offset: 0,
    //   width: 0.8,
    //   radius: radius,
    //   color: const Color.fromRGBO(183, 183, 183, 0.8),
    //   child: DecoratedBox(
    //     decoration: BoxDecoration(
    //       border: context.elBorder,
    //       borderRadius: radius,
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withAlpha(25),
    //           offset: const Offset(0, 14),
    //           blurRadius: 24,
    //           spreadRadius: 0,
    //         ),
    //       ],
    //     ),
    //     child: ClipRRect(
    //       borderRadius: radius,
    //       child: ColoredBox(
    //         color: const Color.fromRGBO(237, 237, 237, 1.0),
    //         child: SizedBox(
    //           width: 136,
    //           height: 70,
    //           child: BackdropFilter(
    //             filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: SizedBox.expand(),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
