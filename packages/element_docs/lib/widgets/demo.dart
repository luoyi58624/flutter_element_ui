import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import '../global.dart';

class ExampleSmoothScroll extends StatefulWidget {
  const ExampleSmoothScroll({
    super.key,
  });

  @override
  State<ExampleSmoothScroll> createState() => _ExampleSmoothScrollState();
}

class _ExampleSmoothScrollState extends State<ExampleSmoothScroll> {
  final ScrollController _scrollController = MyCustomSmoothScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: 1000,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class MyCustomSmoothScrollController extends ScrollController {
  MyCustomSmoothScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return CustomSmoothScrollPosition(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }
}

const double _minDelta = 180.0;

class CustomSmoothScrollPosition extends ScrollPositionWithSingleContext {
  late AnimationController animationController;
  late Animation<double> animation;
  late double targetPixels;
  late double currentPixels;
  Timer? _timer;

  CustomSmoothScrollPosition({
    required super.physics,
    required super.context,
    double super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
  }) {
    targetPixels = pixels;
    currentPixels = pixels;
    animationController = AnimationController(
      vsync: context.vsync,
      duration: const Duration(milliseconds: 150),
    )
      ..addListener(_updateScroll)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          didStartScroll();
          didUpdateScrollPositionBy(pixels - currentPixels);
          didEndScroll();
          goBallistic(0.0);
        }
      });
  }

  @override
  void pointerScroll(double delta) {
    if (PlatformUtil.isWindows) {
      _pointerScroll(delta);
    } else {
      super.pointerScroll(delta);
    }
  }

  void _pointerScroll(double delta) {
    if (delta == 0.0) {
      goBallistic(0.0);
      return;
    }
    if (_timer != null) return;
    _timer = setTimeout(() {
      _timer = null;
    }, 32);

    double $delta = max(_minDelta, delta.abs());
    $delta = delta > 0 ? $delta : -$delta;

    i(delta);
    targetPixels = math.min(
        math.max(targetPixels + $delta, minScrollExtent), maxScrollExtent);
    if (targetPixels != pixels) {
      goIdle();
      updateUserScrollDirection(
        -delta > 0.0 ? ScrollDirection.forward : ScrollDirection.reverse,
      );
      isScrollingNotifier.value = true;

      animation = Tween(
        begin: currentPixels,
        end: targetPixels,
      ).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ));

      animationController.forward(from: 0);
    }
  }

  void _updateScroll() {
    currentPixels = animation.value;
    forcePixels(animation.value);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
