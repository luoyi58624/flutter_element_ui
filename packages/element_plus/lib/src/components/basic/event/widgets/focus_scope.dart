part of '../index.dart';

/// 这个小部件只是对 [FocusScope] 进行一些略微增强，它必须配合 [ElEvent] 小部件才能发挥作用
class ElFocusScope extends StatefulWidget {
  const ElFocusScope({
    super.key,
    required this.child,
  });

  final Widget child;

  /// 请求指针按下时的焦点
  static void requestPointerDownFocus(BuildContext context) {
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
      child: ElEventTheme(
        data: const ElEventThemeData(
          canRequestFocus: true,
        ),
        child: _FocusScopeInheritedWidget(
          pointerDownFocusNode,
          setPointerDownFocusNode,
          child: widget.child,
        ),
      ),
    );
  }
}
