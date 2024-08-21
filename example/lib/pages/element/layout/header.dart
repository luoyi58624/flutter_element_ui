
import 'package:example/global.dart';
import 'package:flutter/material.dart';

class LayoutHeaderWidget extends StatefulWidget {
  const LayoutHeaderWidget({super.key});

  @override
  State<LayoutHeaderWidget> createState() => _LayoutHeaderWidgetState();
}

class _LayoutHeaderWidgetState extends State<LayoutHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: el.theme.headerColor,
      child: const Row(
        children: [
          // ElButton(
          //   onPressed: () {
          //     GlobalState.elMenu.value = GlobalState.elMenu.value.copyWith(
          //       isCollapse: !GlobalState.elMenu.value.isCollapse,
          //     );
          //   },
          //   width: 72,
          //   height: 56,
          //   margin: EdgeInsets.zero,
          //   borderRadius: BorderRadius.zero,
          //   bgColor: el.theme.headerColor,
          //   child: ObsBuilder(builder: (context) {
          //     return ElIcon(
          //       GlobalState.elMenu.value.isCollapse
          //           ? ElIcons.expand
          //           : ElIcons.fold,
          //       size: 22,
          //     );
          //   }),
          // ),
        ],
      ),
    );
  }
}
