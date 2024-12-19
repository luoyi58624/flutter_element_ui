import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

class ElMenu extends StatelessWidget {
  /// Element UI 菜单
  const ElMenu({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final radius = context.commonSizePreset.cardRadius!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.elTheme.modalColor(context),
        borderRadius: radius,
        border: context.elBorder,
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromRGBO(0, 0, 0, 0.1),
        //     offset: Offset(0, 0),
        //     blurRadius: 16,
        //     spreadRadius: 2,
        //   ),
        //   BoxShadow(
        //     color: Color.fromRGBO(0, 0, 0, 0.1),
        //     offset: Offset(0, 1),
        //     blurRadius: 8,
        //     spreadRadius: -1,
        //   ),
        // ],
      ),
      child: SizedBox(
        width: 136,
        height: 70,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}
