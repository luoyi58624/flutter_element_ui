import 'package:element_flutter/element_flutter.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// 初始 fps 帧率，除了 ios、mac 等平台，其他平台的初始帧率需要设置为 -1，因为 [Ticker] 似乎会多执行一帧
final _initialFps = PlatformUtil.isApple ? 0 : -1;

class ElFps extends StatefulWidget {
  /// 显示当前帧率小部件
  const ElFps({
    super.key,
    this.enabled = true,
    required this.child,
    this.positionedBuilder,
  });

  final Widget child;

  /// 是否开启帧率监控
  final bool enabled;

  /// 自定义构建帧率显示位置，你必须通过 [Positioned] 小部件设置定位
  final ElWidgetBuilder? positionedBuilder;

  @override
  State<ElFps> createState() => _ElFpsState();
}

class _ElFpsState extends State<ElFps> with SingleTickerProviderStateMixin {
  /// 帧率显示值
  final fps = Obs(0);

  /// 记录 1 秒内 [_ticker] 的回调次数
  int fpsTime = _initialFps;

  /// 帧率监控计时时间（微秒），每过 1 秒将刷新一次
  late int currentTime;

  /// Ticker 计时器，它内部会根据屏幕刷新信号触发帧回调
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
      fpsTime = _initialFps;
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
  void didUpdateWidget(covariant ElFps oldWidget) {
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

    final fpsWidget = RepaintBoundary(
      child: IgnorePointer(
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
      ),
    );
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          if (widget.enabled) fpsBuilder(context, fpsWidget),
        ],
      ),
    );
  }
}
