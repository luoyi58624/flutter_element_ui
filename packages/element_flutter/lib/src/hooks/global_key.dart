import 'package:flutter/widgets.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 创建 [GlobalKey] 钩子
GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  return use(_Hook<T>());
}

class _Hook<T extends State<StatefulWidget>> extends Hook<GlobalKey<T>> {
  const _Hook();

  @override
  _HookState<T> createState() => _HookState<T>();
}

class _HookState<T extends State<StatefulWidget>>
    extends HookState<GlobalKey<T>, _Hook<T>> {
  late final _key = GlobalKey<T>();

  @override
  GlobalKey<T> build(BuildContext context) => _key;
}
