import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/styles/basic/icon.dart';

import '../../utils/icons.dart';
import '../basic/icon.dart';

class ElLoading extends StatelessWidget {
  const ElLoading({super.key, required this.size, required this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return _LoadingWidget(
      child: ElIcon(
        ElIcons.loading,
        style: ElIconStyle(
          size: size,
          color: color,
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget({
    required this.child,
    this.loading = true,
  });

  final Widget child;
  final bool loading;

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    if (widget.loading) start();
  }

  @override
  void didUpdateWidget(covariant _LoadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading) {
      start();
    } else {
      stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void start() {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  void stop() {
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: _controller,
      child: widget.child,
    );
  }
}
