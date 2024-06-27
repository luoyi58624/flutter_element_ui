import 'package:example/global.dart';
import 'package:flutter/material.dart';

import 'demo.dart';

class LayoutHeaderWidget extends StatefulWidget {
  const LayoutHeaderWidget({super.key});

  @override
  State<LayoutHeaderWidget> createState() => _LayoutHeaderWidgetState();
}

class _LayoutHeaderWidgetState extends State<LayoutHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Demo(
      leading: Center(
        child: ElButton(
          onPressed: () {
            GlobalState.elMenu.value = GlobalState.elMenu.value.copyWith(
              isCollapse: !GlobalState.elMenu.value.isCollapse,
            );
          },
          width: 72,
          height: 56,
          margin: EdgeInsets.zero,
          borderRadius: BorderRadius.zero,
          bgColor: context.elTheme.headerColor,
          child: ObsBuilder(builder: (context) {
            return ElIcon(
              GlobalState.elMenu.value.isCollapse
                  ? ElIcons.expand
                  : ElIcons.fold,
              size: 22,
            );
          }),
        ),
      ),
    );
  }
}
