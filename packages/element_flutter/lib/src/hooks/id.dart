import 'package:flutter/widgets.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 生成唯一 id 钩子
String useId() {
  return use(const _Hook());
}

class _Hook extends Hook<String> {
  const _Hook();

  @override
  _HookState createState() => _HookState();
}

class _HookState extends HookState<String, _Hook> {
  late final _id = uuidStr;

  @override
  String build(BuildContext context) => _id;
}
