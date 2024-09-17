import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

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
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
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
    //use the customscroll position with smooth scrolling
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

class CustomSmoothScrollPosition extends ScrollPositionWithSingleContext {
  int previousScrollTime = DateTime.now()
      .millisecondsSinceEpoch; //used to track time between scrolls same as clragons code

  CustomSmoothScrollPosition({
    required super.physics,
    required super.context,
    double super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
  });

  @override
  void pointerScroll(double delta) {
    // If an update is made to pointer scrolling here, consider if the same
    // (or similar) change should be made in
    // _NestedScrollCoordinator.pointerScroll.
    if (delta == 0.0) {
      goBallistic(0.0);
      return;
    }

    final double targetPixels =
        math.min(math.max(pixels + delta, minScrollExtent), maxScrollExtent);
    if (targetPixels != pixels) {
      goIdle();
      updateUserScrollDirection(
        -delta > 0.0 ? ScrollDirection.forward : ScrollDirection.reverse,
      );
      final double oldPixels = pixels;
      // Set the notifier before calling force pixels.
      // This is set to false again after going ballistic below.
      isScrollingNotifier.value = true;

      //--------------------  NEW CODE STARTS HERE  --------------------
      int deltaScrollTime =
          DateTime.now().millisecondsSinceEpoch - previousScrollTime;
      int animationDuration = deltaScrollTime < 200 ? deltaScrollTime : 200;

      if (animationDuration < 32) {
        //60fps is 16ms per frame so less than 32ms is pointless as its less than 2 frames
        //also avoids calling animateTo too many times in quick succession which seems to be buggy and throws exceptions for elapsed<0  that might be related to github.com/flutter/flutter/issues/106277
        super.pointerScroll(delta);
        return;
      }
      animateTo(
        targetPixels,
        duration: Duration(milliseconds: animationDuration),
        curve: Curves.easeInOut,
      );
      previousScrollTime = DateTime.now().millisecondsSinceEpoch;
      //--------------------  NEW CODE ENDS HERE  --------------------

      //-------------------- THIS IS THE ORIGINAL FORCE PIXELS IMPLEMENTATION OF super.pointerScroll(delta) --------------------
      // forcePixels(targetPixels);
      // didStartScroll();
      // didUpdateScrollPositionBy(pixels - oldPixels);
      // didEndScroll();
      // goBallistic(0.0);
    }
  }
}
