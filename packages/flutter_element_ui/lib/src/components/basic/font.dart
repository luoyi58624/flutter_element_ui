import 'package:flutter/widgets.dart';

/// 管理应用全局字体小部件
class ElFont extends StatelessWidget {
  const ElFont({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _ElFont extends InheritedWidget {
  const _ElFont({
    super.key,
    required super.child,
  });

  static _ElFont of(BuildContext context) {
    final _ElFont? result = context.dependOnInheritedWidgetOfExactType<_ElFont>();
    assert(result != null, 'No _ElFont found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElFont oldWidget) => true;
}
