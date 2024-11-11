import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FpsWidget extends StatefulWidget {
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
  int fps = 0;
  int fpsTime = 0;
  int? currentTime;
  late final Ticker _ticker = createTicker(_timerHandler);

  void _timerHandler(Duration time) {
    if (currentTime == null) {
      currentTime = time.inMilliseconds;
      fpsTime++;
      return;
    }
    if (time.inMilliseconds - currentTime! >= 1000) {
      bool requiredRefresh = fps != fpsTime;
      fps = fpsTime;
      fpsTime = 0;
      currentTime = time.inMilliseconds;
      if (requiredRefresh) setState(() {});
    } else {
      fpsTime++;
    }
  }

  void _startTicker() {
    if (_ticker.isActive == false) {
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
              top: MediaQuery.of(context).viewPadding.top + 8,
              left: 16,
              child: child,
            );

    final fpsWidget = widget.enabled
        ? AbsorbPointer(
            child: ElText(
              fps,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : const SizedBox();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          fpsBuilder(context, fpsWidget),
        ],
      ),
    );
  }
}
