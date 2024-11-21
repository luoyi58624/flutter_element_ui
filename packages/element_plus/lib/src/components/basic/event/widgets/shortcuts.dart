part of '../index.dart';

/// Element UI 快捷键小部件，
class ElShortcuts extends StatelessWidget {
  const ElShortcuts({
    super.key,
    required this.child,
    required this.keyboard,
    this.ctrl = false,
    this.opt = false,
    this.alt = false,
  });

  final Widget child;

  /// 绑定的按键
  final LogicalKeyboardKey keyboard;

  /// ctrl 修饰符
  final bool ctrl;

  /// opt 修饰符
  final bool opt;

  /// alt 修饰符
  final bool alt;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {},
      child: child,
    );
  }
}
