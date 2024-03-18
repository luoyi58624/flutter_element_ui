import 'package:example/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class LayoutHeaderWidget extends StatefulWidget {
  const LayoutHeaderWidget({super.key});

  @override
  State<LayoutHeaderWidget> createState() => _LayoutHeaderWidgetState();
}

class _LayoutHeaderWidgetState extends State<LayoutHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElIcon.svg(ElIcons.fold),
        Expanded(child: SizedBox()),
        // ElIconButton(
        //   ElIcon.svg(ElIcons.setting),
        //   type: ElThemeType.info,
        //   circle: true,
        //   onPressed: () {},
        // ),
        // ValueListenableBuilder(
        //   valueListenable: GlobalState.isDark,
        //   builder: (context, value, child) => Material(
        //     child: Switch(
        //       value: value,
        //       onChanged: (v) {
        //         GlobalState.isDark.value = v;
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
