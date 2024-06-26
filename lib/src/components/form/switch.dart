import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

class ElSwitch extends StatefulWidget {
  const ElSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.height = 24,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double height;

  @override
  State<ElSwitch> createState() => _ElSwitchState();
}

class _ElSwitchState extends State<ElSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(
      begin: Offset(
        -(widget.height / 2),
        0,
      ),
      end: Offset(
        -(widget.height / 2),
        0,
      ),
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elTheme = context.elTheme;
    final $switchSize = widget.height - 4;
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value);
          !widget.value ? controller.forward : controller.reverse();
        }
      },
      child: HoverBuilder(builder: (isHover) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: widget.height,
          width: widget.height * 2,
          decoration: BoxDecoration(
            color: widget.value ? elTheme.primary : elTheme.borderColor,
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          child: SlideTransition(
            position: animation,
            child: UnconstrainedBox(
              child: buildSwitch($switchSize),
            ),
          ),
        );
      }),
    );
  }

  Widget buildSwitch(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
