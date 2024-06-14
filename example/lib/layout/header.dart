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
    return ElHeader(
      leading: Center(
        child: ValueListenableBuilder(
          valueListenable: GlobalState.elMenu,
          builder: (context, value, _) {
            return ElButton(
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
              child: ElIcon(
                value.isCollapse ? ElIcons.expand : ElIcons.fold,
                size: 22,
              ),
            );
          },
        ),
      ),
      title: const Demo(
        Text('text'),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo(this.child, {super.key});

  final dynamic child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
