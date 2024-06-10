import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollAnimator extends StatefulWidget {
  /// Wraps a scrollable widget to animate scroll delta on desktop.
  const ScrollAnimator({
    super.key,
    this.controller,
    this.duration = const Duration(milliseconds: 380),
    this.scrollSpeed = 2,
    this.curve = Curves.easeOutQuart,
    required this.builder,
  });

  /// The scroll controller to use.
  ///
  /// If not provided, a new controller will be created.
  final ScrollController? controller;

  /// The duration of the scroll animation.
  final Duration duration;

  /// The speed at which we scroll.
  final double scrollSpeed;

  /// The curve of the scroll animation.
  final Curve curve;

  /// Builder function for the inner scrollable widget.
  final Widget Function(
      BuildContext context,
      ScrollController controller,
      ScrollPhysics? physics,
      ) builder;

  @override
  State<ScrollAnimator> createState() => _ScrollAnimatorState();
}

class _ScrollAnimatorState extends State<ScrollAnimator> {
  late _ScrollAnimatorController scrollState = _ScrollAnimatorController(
    controller: widget.controller,
    duration: widget.duration,
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: scrollState,
      builder: (context, _) {
        scrollState.handlePipelinedScroll();
        return Listener(
          onPointerSignal: (signalEvent) => scrollState.handleDesktopScroll(
            signalEvent,
            widget.scrollSpeed,
            widget.curve,
          ),
          onPointerDown: scrollState.handleTouchScroll,
          child: widget.builder(
            context,
            scrollState.controller,
            scrollState.physics,
          ),
        );
      },
    );
  }
}

class _ScrollAnimatorController with ChangeNotifier {
  _ScrollAnimatorController({
    ScrollController? controller,
    this.duration = const Duration(milliseconds: 380),
  }) : controller = controller ?? ScrollController();

  final ScrollController controller;
  final Duration duration;
  ScrollPhysics? get physics => _physics;
  ScrollPhysics? _physics;

  void handlePipelinedScroll() async {
    await Future.value();
    _handlePipelinedScroll?.call();
  }

  VoidCallback? _handlePipelinedScroll;

  double _futurePosition = 0;

  bool _prevDeltaPositive = false;
  double? _lastLock;

  Future<void>? _animationEnd;

  static double _calcMaxDelta(ScrollController controller, double delta) {
    return delta > 0
        ? math.min(controller.position.pixels + delta,
        controller.position.maxScrollExtent) -
        controller.position.pixels
        : math.max(controller.position.pixels + delta,
        controller.position.minScrollExtent) -
        controller.position.pixels;
  }

  void handleDesktopScroll(
      PointerSignalEvent event,
      double scrollSpeed,
      Curve animationCurve, [
        bool readLastDirection = true,
      ]) {
    // Ensure desktop physics is being used.
    if (physics == null || _lastLock != null) {
      if (event is PointerScrollEvent) {
        double posPixels = controller.position.pixels;
        if ((posPixels == controller.position.minScrollExtent &&
            event.scrollDelta.dy < 0) ||
            (posPixels == controller.position.maxScrollExtent &&
                event.scrollDelta.dy > 0)) {
          return;
        } else {
          _physics = const NeverScrollableScrollPhysics();
        }
        bool outOfBounds = posPixels < controller.position.minScrollExtent ||
            posPixels > controller.position.maxScrollExtent;
        double calcDelta = _calcMaxDelta(controller, event.scrollDelta.dy);
        if (!outOfBounds) {
          controller.jumpTo(_lastLock ?? (posPixels - calcDelta));
        }
        double deltaDelta = calcDelta - event.scrollDelta.dy;
        _handlePipelinedScroll = () {
          _handlePipelinedScroll = null;
          double currPos = controller.position.pixels;
          double currDelta = event.scrollDelta.dy;
          bool shouldLock = _lastLock != null
              ? (_lastLock == currPos)
              : (posPixels != currPos + deltaDelta &&
              (currPos != controller.position.maxScrollExtent ||
                  currDelta < 0) &&
              (currPos != controller.position.minScrollExtent ||
                  currDelta > 0));
          if (!outOfBounds && shouldLock) {
            controller.jumpTo(posPixels);
            _lastLock = posPixels;
            controller.position.moveTo(posPixels).whenComplete(() {
              _physics = null;
              notifyListeners();
            });
            return;
          } else {
            if (_lastLock != null || outOfBounds) {
              controller.jumpTo(_lastLock != null
                  ? posPixels
                  : (currPos - _calcMaxDelta(controller, currDelta)));
            }
            _lastLock = null;
            handleDesktopScroll(event, scrollSpeed, animationCurve, false);
          }
        };
        notifyListeners();
      }
      return;
    } else if (event is PointerScrollEvent) {
      bool currentDeltaPositive = event.scrollDelta.dy > 0;
      if (readLastDirection && currentDeltaPositive == _prevDeltaPositive) {
        _futurePosition += event.scrollDelta.dy * scrollSpeed;
      } else {
        _futurePosition =
            controller.position.pixels + event.scrollDelta.dy * scrollSpeed;
      }
      _prevDeltaPositive = event.scrollDelta.dy > 0;

      Future<void> animationEnd = _animationEnd = controller.animateTo(
        _futurePosition,
        duration: duration,
        curve: animationCurve,
      );

      animationEnd.whenComplete(() {
        if (animationEnd != _animationEnd) return;
        if (physics == null) return;
        _physics = null;
        notifyListeners();
      });
    }
  }

  void handleTouchScroll(PointerDownEvent event) {
    if (physics == null) return;
    _physics = null;
    notifyListeners();
  }
}
