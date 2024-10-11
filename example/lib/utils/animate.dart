import 'package:flutter/animation.dart';

class AnimateUtil {}

extension AnimateExt on AnimationController {
  Animation<T> createAnimate<T>({
    required Tween<T> tween,
    Curve curve = Curves.linear,
  }) {
    return tween.animate(
      CurvedAnimation(
        parent: this,
        curve: curve,
      ),
    );
  }
}
