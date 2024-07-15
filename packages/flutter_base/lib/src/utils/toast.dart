import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast _toast = FToast();

/// Flutter轻提示
class ToastUtil {
  ToastUtil._();

  /// 默认toast的透明度
  static double _opacity = 0.75;

  /// 所有toast的默认持续时间
  static int _duration = 3;

  /// 显示toast时是否触发系统震动
  static bool _hapticFeedback = false;
  static Color _primary = const Color.fromARGB(255, 0, 120, 212);
  static Color _success = const Color.fromARGB(255, 16, 185, 129);
  static Color _info = const Color.fromARGB(255, 127, 137, 154);
  static Color _warning = const Color.fromARGB(255, 245, 158, 11);
  static Color _error = const Color.fromARGB(255, 239, 68, 68);

  /// 创建[Overlay]遮罩层，若没遮罩层，那么toast将无法使用
  /// ```dart
  /// MaterialApp(
  ///   builder: AppWidget.builder(),
  /// );
  ///
  /// // 插入你自己自定义的builder方法
  /// MaterialApp(
  ///   builder: AppWidget.builder(
  ///     (context, child) => SizeBox(child: child!),
  ///   ),
  /// );
  /// ```
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        Widget overlayWidget = Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              _toast.init(context);
              return child!;
            })
          ],
        );
        return builder == null
            ? overlayWidget
            : builder(context, overlayWidget);
      };

  /// 设置toast属性
  static void setup({
    double? opacity,
    int? duration,
    bool? hapticFeedback,
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
  }) {
    _opacity = opacity ?? _opacity;
    _duration = duration ?? _duration;
    _hapticFeedback = hapticFeedback ?? _hapticFeedback;
    _primary = primary ?? _primary;
    _success = success ?? _success;
    _info = info ?? _info;
    _warning = warning ?? _warning;
    _error = error ?? _error;
  }

  /// 显示一个默认风格的轻提示
  /// * duration 持续时间，单位秒
  /// * opacity 提示的透明度，默认0.75
  /// * hapticFeedback 是否触发系统震动提示，默认true
  static void show(
    dynamic title, {
    int? duration,
    double? opacity,
    bool? hapticFeedback,
  }) {
    if (hapticFeedback ?? _hapticFeedback) HapticFeedback.vibrate();
    _toast.removeCustomToast();
    _toast.showToast(
      child: _DefaultToastWidget(title: title, opacity: opacity ?? _opacity),
      toastDuration: Duration(seconds: duration ?? _duration),
      gravity: ToastGravity.CENTER,
    );
  }

  /// primary颜色的轻提示
  static void primary(
    dynamic title, {
    int? duration,
    bool? hapticFeedback,
  }) {
    _buildToast(
      _OtherToastWidget(
        title: title,
        backgroundColor: _primary,
      ),
      duration: duration ?? _duration,
      hapticFeedback: hapticFeedback ?? _hapticFeedback,
    );
  }

  /// success颜色的轻提示
  static void success(
    dynamic title, {
    int? duration,
    bool? hapticFeedback,
  }) {
    _buildToast(
      _OtherToastWidget(
        title: title,
        backgroundColor: _success,
      ),
      duration: duration ?? _duration,
      hapticFeedback: hapticFeedback ?? _hapticFeedback,
    );
  }

  /// info颜色的轻提示
  static void info(
    dynamic title, {
    int? duration,
    bool? hapticFeedback,
  }) {
    _buildToast(
      _OtherToastWidget(
        title: title,
        backgroundColor: _info,
      ),
      duration: duration ?? _duration,
      hapticFeedback: hapticFeedback ?? _hapticFeedback,
    );
  }

  /// warning颜色的轻提示
  static void warning(
    dynamic title, {
    int? duration,
    bool? hapticFeedback,
  }) {
    _buildToast(
      _OtherToastWidget(
        title: title,
        backgroundColor: _warning,
      ),
      duration: duration ?? _duration,
      hapticFeedback: hapticFeedback ?? _hapticFeedback,
    );
  }

  /// error颜色的轻提示
  static void error(
    dynamic title, {
    int? duration,
    bool? hapticFeedback,
  }) {
    _buildToast(
      _OtherToastWidget(
        title: title,
        backgroundColor: _error,
      ),
      duration: duration ?? _duration,
      hapticFeedback: hapticFeedback ?? _hapticFeedback,
    );
  }

  /// 构建一个自定义widget的toast，如果当前页面已经有一个toast，则会关闭它重新显示新的toast
  static void _buildToast(
    Widget toastWidget, {
    required int duration,
    required bool hapticFeedback,
  }) {
    if (hapticFeedback) HapticFeedback.vibrate();
    _toast.removeCustomToast();
    _toast.showToast(
      child: toastWidget,
      toastDuration: Duration(seconds: duration),
      positionedToastBuilder: (context, child) {
        return Positioned(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          child: child,
        );
      },
    );
  }
}

/// 默认风格Toast组件
class _DefaultToastWidget extends StatelessWidget {
  const _DefaultToastWidget({
    required this.title,
    required this.opacity,
  });

  final String title;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toast.removeCustomToast();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Color.fromRGBO(82, 82, 82, opacity)
              : Color.fromRGBO(0, 0, 0, opacity),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

/// 更多风格样式的Toast组件
class _OtherToastWidget extends StatelessWidget {
  const _OtherToastWidget({
    required this.title,
    required this.backgroundColor,
  });

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toast.removeCustomToast();
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(200.0),
        clipBehavior: Clip.antiAlias,
        child: Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            decoration: BoxDecoration(color: backgroundColor),
            child: Text(
              title,
              style: const TextStyle(
                height: 1.5,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
