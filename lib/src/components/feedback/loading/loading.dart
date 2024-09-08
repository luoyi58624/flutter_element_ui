import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/global.dart';


import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import '../../../service.dart';
import '../../../utils/icons.dart';
import '../../basic/icon.dart';

part 'util.dart';

class ElLoading extends StatelessWidget {
  const ElLoading({super.key, required this.size, required this.color});

  final double? size;
  final Color? color;

  /// 显示 Loading 弹窗，如果之前打开了一个，将关闭之前的弹窗。
  ///
  /// 请注意：如果你在 initState 生命周期中使用它（例如在 initState 中执行网络请求），
  /// 请在 WidgetsBinding.instance.addPostFrameCallback 回调函数中调用，它会在UI构建完成后执行一次回调。
  ///
  /// 示例：
  /// ```dart
  ///  @override
  ///  void initState() {
  ///     super.initState();
  ///     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  ///       loading.show('请求数据中');
  ///       await Future.delayed(const Duration(seconds: 2));
  ///       loading.close();
  ///     });
  ///  }
  /// ```
  static void show(
    String text, {
    // 延迟关闭loading，它可以防止异步逻辑执行过快造成视觉闪烁，例如异步逻辑执行了50毫秒，
    // 那么loading会在50毫秒后关闭，页面会突然闪出一个弹窗然后瞬间关闭，此时用户体验非常不好；

    // 注意：如果你执行完异步逻辑后需要返回上一页，执行_LoadingUtil.close时需要添加await，
    // 因为延迟关闭loading是不会阻塞后面代码的执行，关闭弹窗实际上只是执行弹出路由：router.back()，
    // 所以，如果你执行完异步逻辑后需要返回上一页，你必须等待loading关闭后再执行 router.back() 进行返回操作，
    // 否则你只是直接关闭了loading。
    int delayClose = 0,
    // 取消请求提示文字
    String cancelText = '你要关闭 Loading 吗?',
    // 当loading被手动关闭时的回调函数
    void Function()? onCancel,
  }) {
    _LoadingUtil.show(text,
        delayClose: delayClose, cancelText: cancelText, onCancel: onCancel);
  }

  /// 如果页面上存在loading弹窗，则关闭。
  ///
  /// immedClose - 是否立即关闭弹窗
  static Future<void> close([bool? immedClose]) async {
    return await _LoadingUtil.close(immedClose);
  }

  @override
  Widget build(BuildContext context) {
    return _LoadingWidget(
      child: ElIcon(
        ElIcons.loading,
        size: size,
        color: color,
      ),
    );
  }
}

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget({
    required this.child,
    this.loading = true,
  });

  final Widget child;
  final bool loading;

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    if (widget.loading) start();
  }

  @override
  void didUpdateWidget(covariant _LoadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading) {
      start();
    } else {
      stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void start() {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  void stop() {
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: _controller,
      child: widget.child,
    );
  }
}
