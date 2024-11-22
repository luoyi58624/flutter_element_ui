part of '../index.dart';

class ElFocusScopeApi {
  ElFocusScopeApi._(
    this.hasFocus,
    this.requestFocus,
    this.unfocus,
  );

  /// 焦点组是否聚焦，只要内部任意一个 [ElFocus] 得到焦点，那么此变量将为 true
  final bool hasFocus;

  /// 焦点组请求焦点
  final VoidCallback requestFocus;

  /// 焦点组取消焦点
  final VoidCallback unfocus;
}

/// 管理一组 [ElFocus] 焦点小部件，[ElFocusScope] 必须配合 [ElFocus] + [ElEvent] 一起使用，
/// 这个组合简化了 Flutter 中的焦点处理：
/// * [ElEvent] 在指针按下时，会拿到 [ElFocus] 的焦点并设置到 [ElFocusScope] 中
/// * [ElEvent] 在指针抬起时，如果事件没有被取消，则会自动激活选中的焦点
///
/// 然后是失去焦点处理：
/// * 如果 [ElFocus] 不在 [ElFocusScope] 中，那么点击元素外部将会失去焦点
/// * 如果 [ElFocus] 在 [ElFocusScope] 中，那么当点击 [ElFocusScope] 外部时才会失去焦点
class ElFocusScope extends StatefulWidget {
  const ElFocusScope({
    super.key,
    required this.child,
  });

  final Widget child;

  /// 焦点组是否得到焦点
  static bool hasFocus(BuildContext context) =>
      _FocusScopeInheritedWidget.getFocusStatus(context);

  /// 焦点组请求焦点，注意：不要通过 [of] 请求焦点
  static void requestFocus(BuildContext context) {
    final result = _FocusScopeInheritedWidget.maybeOf(context);
    if (result != null) {
      result.childFocusNode?.requestFocus();
    }
  }

  /// 通过上下文获取 [FocusScopeNode] 焦点组对象
  static FocusScopeNode of(BuildContext context) {
    assert(_FocusScopeInheritedWidget.maybeOf(context) != null,
        'ElFocusScope.of 没有找到实例对象，请尝试使用 Builder 小部件转发 context');
    return _FocusScopeInheritedWidget.maybeOf(context)!.focusScopeNode;
  }

  @override
  State<ElFocusScope> createState() => _ElFocusScopeState();
}

class _ElFocusScopeState extends State<ElFocusScope> {
  final FocusScopeNode focusScopeNode = FocusScopeNode();
  bool hasDepend = false;
  bool _hasFocus = false;

  set hasFocus(bool value) {
    if (hasDepend) {
      if (_hasFocus != value) {
        setState(() {
          _hasFocus = value;
        });
      }
    }
  }

  /// 内部 [ElFocus] 预设焦点，[ElEvent] 会在指针按下那一瞬间便立即将选中的焦点设置到此变量
  FocusNode? childFocusNode;

  void setChildFocus(FocusNode? node) {
    if (node != null) childFocusNode = node;
  }

  void setDepend() {
    hasDepend = true;
  }

  @override
  void initState() {
    super.initState();
    focusScopeNode.addListener(() {
      hasFocus = focusScopeNode.hasFocus;
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusScopeNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (e) {
        if (focusScopeNode.hasFocus) focusScopeNode.unfocus();
      },
      child: FocusScope(
        node: focusScopeNode,
        child: _FocusScopeInheritedWidget(
          _hasFocus,
          setDepend,
          focusScopeNode,
          childFocusNode,
          setChildFocus,
          child: widget.child,
        ),
      ),
    );
  }
}
