import 'dart:math';

import 'package:flutter/material.dart';

class Ripper extends StatefulWidget {
  const Ripper({super.key, required this.child});

  final Widget child;

  @override
  State<Ripper> createState() => _RipperState();
}

class _RipperState extends State<Ripper> {
  final List<({Offset position, double size})> _rippers = [];

  void _addRipper(Offset position, Size size) {
    setState(() {
      _rippers.add((
        position: position,
        size: max(size.width, size.height),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        GestureDetector(
          onTapDown: (e) {
            _addRipper(e.localPosition, context.size!);
          },
          child: widget.child,
        ),
        ..._rippers.map(
          (e) => const Positioned.fill(
            child: _RipperAnimate(),
          ),
        ),
      ],
    );
  }
}

class _RipperAnimate extends StatefulWidget {
  const _RipperAnimate();

  @override
  State<_RipperAnimate> createState() => _RipperAnimateState();
}

class _RipperAnimateState extends State<_RipperAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 200),
  );

  @override
  void initState() {
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black45,
    );
  }
}
