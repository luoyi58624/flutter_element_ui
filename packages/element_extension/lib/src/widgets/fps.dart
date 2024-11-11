import 'package:element_extension/element_extension.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// 初始 fps 帧率，除了 ios、mac 等平台，其他平台的初始帧率需要设置为 -1，因为 [Ticker] 似乎会多执行一帧
final _initialFps = PlatformUtil.isApple ? 0 : -1;

class FpsWidget extends StatefulWidget {
  /// 显示当前帧率小部件，内部通过 [Ticker] 做计算
  const FpsWidget({
    super.key,
    this.enabled = true,
    required this.child,
    this.positionedBuilder,
  });

  final bool enabled;
  final Widget child;

  /// 帧率显示位置构建
  final ElWidgetBuilder? positionedBuilder;

  @override
  State<FpsWidget> createState() => _FpsWidgetState();
}

class _FpsWidgetState extends State<FpsWidget>
    with SingleTickerProviderStateMixin {
  final fps = Obs(0);

  int fpsTime = _initialFps;
  late int currentTime;
  late final Ticker _ticker = createTicker(_timerHandler);

  void _timerHandler(Duration time) {
    if (time.inMicroseconds - currentTime >= 1000000) {
      fps.value = fpsTime;
      fpsTime = _initialFps;
      currentTime = time.inMicroseconds;
    }
    fpsTime++;
  }

  void _startTicker() {
    if (_ticker.isActive == false) {
      currentTime = 0;
      _ticker.start();
    }
  }

  void _stopTicker() {
    if (_ticker.isActive) {
      _ticker.stop();
    }
  }

  @override
  void initState() {
    if (widget.enabled) _startTicker();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FpsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _startTicker();
      } else {
        _stopTicker();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fpsBuilder = widget.positionedBuilder ??
        (context, child) => Positioned(
              top: MediaQuery.of(context).viewPadding.top + 64,
              right: 20,
              child: child,
            );

    final fpsWidget = IgnorePointer(
      child: ObsBuilder(builder: (context) {
        return ElText(
          '$fps',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          if (widget.enabled) fpsBuilder(context, fpsWidget),
        ],
      ),
    );
  }
}
