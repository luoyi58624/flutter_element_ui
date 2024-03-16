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
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          ElIcon.svg(ElIcons.fold),
          Expanded(child: SizedBox()),
          ElButton.icon(
            ElIcon.svg(ElIcons.setting),
            type: ElThemeType.info,
            circle: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
