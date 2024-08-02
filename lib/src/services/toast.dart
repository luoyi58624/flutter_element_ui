import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../core.dart';

mixin ElToastService {
  /// Element UI 轻提示实例对象，在屏幕上显示一段简单的文本提示，每次只能显示一条消息
  final ElToastInstance toast = ElToastInstance();
}

class ElToastInstance {
  OverlayEntry? _toastOverlayEntry;
  Timer? _removeToastTimer;

  /// 显示轻提示，默认风格是中间显示半透明的黑底白字一段文本
  /// * context 默认使用全局context，如果你需要让它作用于局部页面，请传递当前context
  /// * duration 持续时间，单位毫秒
  /// * type 主题类型，如果不为空，将构建 [_ThemeToast]
  /// * offset 自定义 toast 的底部偏移值
  /// * builder 自定义构建 toast 小部件，支持全局配置
  void show(
    dynamic content, {
    BuildContext? context,
    int duration = 3000,
    String? type,
    double offset = 20,
    Widget Function(dynamic content)? builder,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(builder: (context) {
      return builder != null
          ? builder(content)
          : type == null
              ? _Toast(content)
              : _ThemeToast(content, type, offset);
    });
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  /// primary 主题轻提示
  void primary(
    dynamic content, {
    BuildContext? context,
    int duration = 3000,
    double offset = 20,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(
        builder: (context) => _ThemeToast(content, 'primary', offset));
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  /// success 主题轻提示
  void success(
    dynamic content, {
    BuildContext? context,
    int duration = 3000,
    double offset = 20,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(
        builder: (context) => _ThemeToast(content, 'success', offset));
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  /// info 主题轻提示
  void info(
    dynamic content, {
    BuildContext? context,
    int duration = 3000,
    double offset = 20,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(
        builder: (context) => _ThemeToast(content, 'info', offset));
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  /// warning 主题轻提示
  void warning(
    dynamic content, {
    BuildContext? context,
    int duration = 3000,
    double offset = 20,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(
        builder: (context) => _ThemeToast(content, 'warning', offset));
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  /// error 主题轻提示
  void error(
    dynamic content, {
    BuildContext? context,
    int duration = 3000,
    double offset = 20,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(
        builder: (context) => _ThemeToast(content, 'error', offset));
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  /// 自定义构建轻提示
  void builder(
    dynamic content,
    Widget Function(dynamic content) builder, {
    BuildContext? context,
    int duration = 3000,
  }) async {
    await _beforeHook();
    _toastOverlayEntry = OverlayEntry(builder: (context) => builder(content));
    final $context = context ?? el.context;
    if ($context.mounted) _afterHook($context, duration);
  }

  Future<void> _beforeHook() async {
    remove();
    if (_removeToastTimer != null) {
      _removeToastTimer!.cancel();
      _removeToastTimer = null;
    }
    await 0.05.seconds.delay();
  }

  void _afterHook(BuildContext context, int duration) {
    Overlay.of(context).insert(_toastOverlayEntry!);
    _removeToastTimer = remove.delay(duration);
  }

  /// 移除当前轻提示
  void remove() {
    if (_toastOverlayEntry != null) {
      _toastOverlayEntry!.remove();
      _toastOverlayEntry = null;
    }
  }
}

class _Toast extends StatelessWidget {
  const _Toast(this.content);

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: el.toast.remove,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: context.isDark
                ? const Color.fromRGBO(82, 82, 82, 0.85)
                : const Color.fromRGBO(0, 0, 0, 0.65),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$content',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToast extends StatelessWidget {
  const _ThemeToast(this.content, this.type, this.bottomOffset);

  final dynamic content;
  final String type;
  final double bottomOffset;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
        vertical: bottomPadding >= bottomOffset
            ? bottomPadding + bottomOffset / 2
            : bottomOffset,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: el.toast.remove,
          child: UnconstrainedBox(
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(200.0),
              clipBehavior: Clip.antiAlias,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: context.elThemeColors[type]),
                  child: Text(
                    '$content',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
