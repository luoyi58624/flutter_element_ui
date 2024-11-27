part of '../index.dart';

/// 这个小部件只是对 [FocusScope] 进行一些略微增强，它需要配合 [ElEvent] 小部件一起工作，
/// 如果 [ElEvent] 祖先存在 [ElFocusScope]，那么将会创建 [Focus] 小部件，
/// 同时添加 [LookupBoundary] 进行隔离，防止嵌套 [ElEvent] 重复创建 [Focus]。
class ElFocusScope extends StatefulWidget {
  const ElFocusScope({
    super.key,
    required this.child,
  });

  final Widget child;

  /// 请求焦点，与 [FocusScopeNode] 不同的是，它请求的是指针按下时的焦点
  static void requestFocus(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_FocusScopeInheritedWidget>();
    if (result != null) {
      result.pointerDownFocusNode?.requestFocus();
    }
  }

  @override
  State<ElFocusScope> createState() => _ElFocusScopeState();
}

class _ElFocusScopeState extends State<ElFocusScope> {
  /// 记录指针按下时选中的焦点
  FocusNode? pointerDownFocusNode;

  void setPointerDownFocusNode(FocusNode? node) {
    if (node != null) pointerDownFocusNode = node;
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: ElStopPropagation(
        child: _FocusScopeInheritedWidget(
          pointerDownFocusNode,
          setPointerDownFocusNode,
          child: widget.child,
        ),
      ),
    );
  }
}
