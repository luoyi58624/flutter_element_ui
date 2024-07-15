import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

/// 自动注入、销毁[Getx]控制器hook，注意：仅限mini_getx
/// * tag 控制器标签
/// * showLog 注入控制器、销毁控制器时是否在控制台显示日志
///
/// ```dart
/// class Controller extends GetxController {
///   final count = 0.obs;
/// }
///
/// class GetxHook extends HookWidget {
///   const GetxHook({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final c = useGetx(Controller());
///     return ElevatedButton(
///       onPressed: () => c.count.value++,
///       child: Obx(() => Text('count: ${c.count.value}')),
///     );
///   }
/// }
/// ```
T useGetx<T extends GetxController>(
  T controller, {
  String? tag,
  bool showLog = true,
}) {
  return use(_Controller(controller, tag, showLog));
}

class _Controller<T extends GetxController> extends Hook<T> {
  const _Controller(this.controller, this.tag, this.showLog);

  final T controller;
  final String? tag;
  final bool showLog;

  @override
  _ControllerState<T> createState() => _ControllerState();
}

class _ControllerState<T extends GetxController>
    extends HookState<T, _Controller<T>> {
  late final T c = Get.put(hook.controller, tag: hook.tag);

  @override
  T build(BuildContext context) => c;

  @override
  void dispose() {
    Get.delete<T>(tag: hook.tag);
  }
}

class Controller extends GetxController {
  final count = 0.obs;
}
