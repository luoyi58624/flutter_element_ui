import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

const int _duration = 225;

/// Element UI 抽屉组件，当显示、关闭时可以保留内部的状态
class ElDrawer extends StatefulWidget {
  const ElDrawer(
    this.modelValue, {
    super.key,
    required this.child,
    this.width = 300,
  });

  final Widget child;
  final ValueNotifier<bool> modelValue;
  final double width;

  @override
  State<ElDrawer> createState() => _ElDrawerState();
}

class _ElDrawerState extends State<ElDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late final OverlayEntry overlayEntry;
  Animation<double>? _positionAnimation;
  Animation<double>? _opacityAnimation;
  late double position = -widget.width;
  double opacity = 0;

  late final Widget overlayWidget = ValueListenableBuilder(
    valueListenable: widget.modelValue,
    builder: (context, value, _) {
      return Offstage(
        offstage: !value,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  controller.reverse();
                  await (_duration / 1000).delay();
                  widget.modelValue.value = false;
                },
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, _opacityAnimation!.value),
                  alignment: Alignment.topLeft,
                ),
              ),
              Positioned(
                top: 0.0,
                bottom: 0.0,
                left: _positionAnimation!.value,
                child: Container(
                  width: widget.width,
                  color: context.elTheme.modalColor,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: _duration.ms, vsync: this);
    _positionAnimation = Tween<double>(begin: position, end: 0).animate(
        CurvedAnimation(parent: controller, curve: const Cubic(0, 0, 0.2, 1)));
    _opacityAnimation = Tween<double>(begin: opacity, end: 0.54).animate(
        CurvedAnimation(
            parent: controller, curve: const Cubic(0.4, 0, 0.2, 1)));

    widget.modelValue.addListener(_listen);

    ElUtil.nextTick(() async {
      overlayEntry = OverlayEntry(builder: (_) {
        return overlayWidget;
      });
      Overlay.of(context, rootOverlay: true).insert(overlayEntry);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    widget.modelValue.removeListener(_listen);
    super.dispose();
    overlayEntry.remove();
  }

  void _listen() {
    if (widget.modelValue.value) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
