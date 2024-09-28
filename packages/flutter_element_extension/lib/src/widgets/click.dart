import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// 点击事件小部件，它与 [GestureDetector] 不同在于，即使手势竞争失败也依然会触发点击事件，
/// 同时，你可以
class Click extends StatelessWidget {
  const Click({
    super.key,
    required this.onClick,
    required this.child,
  });

  final VoidCallback onClick;
  final Widget child;

  static void stopPropagation(BuildContext context){

  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        _AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            _AllowMultipleGestureRecognizer>(
          () => _AllowMultipleGestureRecognizer(),
          (_AllowMultipleGestureRecognizer instance) {
            instance.onTap = onClick;
          },
        )
      },
      child: child,
    );
  }
}

class _AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
