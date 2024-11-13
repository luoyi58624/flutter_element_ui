import 'dart:async';
import 'dart:math';

import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

part 'listener.dart';

part 'stop_propagation.dart';

/// 事件冒泡支持的类型，你可以精准控制需要阻止哪些事件
enum ElEventType {
  /// 悬停事件
  hover,

  /// 点击事件
  tap,

  /// 辅助点击事件，例如：鼠标右键
  secondaryTap,

  /// 双击事件
  doubleTap,

  /// 长按事件
  longPress,
}

abstract class _Event extends StatefulWidget {
  /// 控制事件触发小部件抽象类
  const _Event({super.key});

  /// 阻止事件冒泡，执行此函数会从当前持有的 context 开始，一层一层阻止所有祖先注册的事件。
  ///
  /// 提示：此函数不会引起 UI 重建，它只是更新一个 bool 标识，同时它是通过 [InheritedWidget] 查找祖先小部件，
  /// 查找效率为 O(1)，所以它不会造成性能问题。
  static void stopPropagation(BuildContext context) {
    _EventInheritedWidget._stopPropagation(context);
  }

  /// 重置事件冒泡
  static void resetPropagation(BuildContext context) {
    _EventInheritedWidget._resetPropagation(context);
  }
}

abstract class _EventState<T extends _Event> extends State<T> {
  /// 一个标识，表示是否允许触发事件执行
  bool allowed = true;

  void _stopPropagation() {
    if (allowed) {
      allowed = false;
      // 继续通过当前 context 查找上一层注册的事件，如果没找到就意味着流程结束
      _EventInheritedWidget._stopPropagation(context);
    }
  }

  void _resetPropagation() {
    if (!allowed) {
      allowed = true;
      _EventInheritedWidget._resetPropagation(context);
    }
  }

  void reset() {
    if (mounted) {
      final result =
          context.getInheritedWidgetOfExactType<_EventInheritedWidget>();
      if (result != null) {
        setTimeout(() {
          result.resetPropagation();
        }, 1);
      }
    }
  }

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return _EventInheritedWidget(
      stopPropagation: _stopPropagation,
      resetPropagation: _resetPropagation,
      child: builder(context),
    );
  }
}

class _EventInheritedWidget extends InheritedWidget {
  const _EventInheritedWidget({
    required super.child,
    required this.stopPropagation,
    required this.resetPropagation,
  });

  final VoidCallback stopPropagation;
  final VoidCallback resetPropagation;

  static void _stopPropagation(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_EventInheritedWidget>();
    if (result != null) result.stopPropagation();
  }

  static void _resetPropagation(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_EventInheritedWidget>();
    if (result != null) result.resetPropagation();
  }

  @override
  bool updateShouldNotify(_EventInheritedWidget oldWidget) => false;
}
