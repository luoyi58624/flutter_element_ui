import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';

part 'state.dart';

extension ElFocusExtension on BuildContext {
  /// 通过当前上下文访问最近的 Focus 聚焦状态
  bool get isFocus => ElFocus.isFocus(this);

  /// 通过当前上下文访问最近的 [FocusNode] 焦点对象，如果为空，则表示没有 [ElFocus] 小部件
  FocusNode? get focusNode => ElFocus.focusNode(this);
}

/// Element UI 聚焦小部件，通常情况它应该放在 [ElEvent] 之上，[ElEvent] 内部会自动帮你处理元素聚焦状态，
/// 如果你需要控制聚焦范围，请参阅 [FocusScope] 小部件。
class ElFocus extends StatefulWidget {
  /// 聚焦小部件构造器，它很简单，你只需要关注 [isFocus]、[focusNode] 两个变量：
  /// * [isFocus] - 顾名思义，它表示当前是否被聚焦，你可以通过此变量设置元素聚焦外观样式
  /// * [focusNode] - Flutter 提供的 [ChangeNotifier] 对象，你可以通过此对象请求焦点、取消焦点
  const ElFocus({
    super.key,
    required this.child,
    this.autofocus,
    this.disabled,
  });

  final Widget child;

  /// 是否自动聚焦，此属性会继承 [ElEventTheme]
  final bool? autofocus;

  /// 是否禁用，此属性会继承 [ElEventTheme]，若为 true，将不允许请求焦点
  final bool? disabled;

  /// 通过上下文获取最近的聚焦状态
  static bool isFocus(BuildContext context) =>
      _FocusInheritedWidget.getFocusStatus(context);

  /// 通过上下文获取最近的聚焦状态
  static FocusNode? focusNode(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_FocusInheritedWidget>()?.focusNode;

  @override
  State<ElFocus> createState() => _ElFocusState();
}
