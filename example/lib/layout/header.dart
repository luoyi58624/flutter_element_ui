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
    return Row(
      children: [
        HoverBuilder(
          builder: (isHover) => GestureDetector(
            onTap: () {
              GlobalState.elMenu.value = GlobalState.elMenu.value.copyWith(
                isCollapse: !GlobalState.elMenu.value.isCollapse,
              );
            },
            child: Container(
              width: 64,
              height: double.infinity,
              color: context.elTheme.headerColor.onHover(context, isHover),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: GlobalState.elMenu,
                  builder: (context, value, _) {
                    return ElIcon.svg(
                      value.isCollapse ? ElIcons.expand : ElIcons.fold,
                      size: 22,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
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
