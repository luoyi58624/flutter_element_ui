part of '../index.dart';

/// 这个小部件只是对 [FocusScope] 进行一些略微增强，它必须配合 [ElEvent]
class ElFocusScope extends StatefulWidget {
  const ElFocusScope({
    super.key,
    required this.child,
  });

  /// 排除焦点组的选中
  const ElFocusScope.exclude({
    super.key,
    required this.child,
  });

  final Widget child;

  /// 请求指针按下时的焦点
  static void requestPoinerDownFocus(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_FocusScopeInheritedWidget>();
    if (result != null) {
      result.poinerDownFocusNode?.requestFocus();
    }
  }

  @override
  State<ElFocusScope> createState() => _ElFocusScopeState();
}

class _ElFocusScopeState extends State<ElFocusScope> {
  /// 记录指针按下时选中的焦点
  FocusNode? poinerDownFocusNode;

  void setPoinerDownFocusNode(FocusNode? node) {
    if (node != null) poinerDownFocusNode = node;
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: _FocusScopeInheritedWidget(
        poinerDownFocusNode,
        setPoinerDownFocusNode,
        child: widget.child,
      ),
    );
  }
}
