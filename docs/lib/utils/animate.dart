import 'package:flutter/animation.dart';

class AnimateUtil {}

extension AnimateExt on AnimationController {
  Animation<T> createAnimate<T>(
    T begin,
    T end, {
    Curve curve = Curves.linear,
  }) {
    return Tween<T>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: this,
        curve: curve,
      ),
    );
  }
}
