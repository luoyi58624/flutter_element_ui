import 'package:flutter/widgets.dart';
import 'package:flutter_element_dart/flutter_element_dart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 生成唯一 id 钩子
String useId() {
  return use(const _IdHook());
}

class _IdHook extends Hook<String> {
  const _IdHook();

  @override
  _IdHookState createState() => _IdHookState();
}

class _IdHookState extends HookState<String, _IdHook> {
  late final _id = uuidStr;

  @override
  String build(BuildContext context) => _id;
}
