import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../global.dart';

mixin GlobalTickerProviderMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  Ticker? _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _ticker = Ticker(onTick);
    return _ticker!;
  }

  @override
  void dispose() {
    _ticker!.dispose();
    super.dispose();
  }
}

class MyUtil {
  MyUtil._();

  static const vsync = _TickerProvider();

  static final controller = AnimationController(vsync: vsync)
    ..addStatusListener((status) {
      i(status);
    });
}

class _TickerProvider implements TickerProvider {
  const _TickerProvider();

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
