part of '../index.dart';

/// Element UI 聚焦小部件，通常情况它应该放在 [ElEvent] 之上，[ElEvent] 内部会帮你处理元素聚焦状态，
/// 当一个元素得到焦点时，点击外部区域会移除它所获得的焦点。
class ElFocus extends StatefulWidget {
  const ElFocus({
    super.key,
    required this.child,
    this.autofocus,
    this.skipTraversal,
    this.disabled,
  });

  final Widget child;

  /// 是否自动聚焦，此属性会继承 [ElEventTheme]
  final bool? autofocus;


  final bool? skipTraversal;

  /// 是否禁用，此属性会继承 [ElEventTheme]，若为 true，将不允许请求焦点
  final bool? disabled;

  /// 通过当前上下文访问最近的 Focus 聚焦状态
  static bool isFocus(BuildContext context) =>
      _FocusInheritedWidget.getFocusStatus(context);

  /// 与 [isFocus] 不同的是，如果用户通过点击、触摸元素得到的聚焦，此变量不会发生更新，
  /// 只有当用户通过键盘导航时得到的聚焦，此变量才会变成 true，它的行为类似 css 中的 focus-visible 伪类：
  /// https://developer.mozilla.org/en-US/docs/Web/CSS/:focus-visible
  static bool isFocusVisible(BuildContext context) =>
      _FocusInheritedWidget.getFocusVisibleStatus(context);

  /// 通过当前上下文访问最近的 [FocusNode] 焦点对象，如果为空，则表示没有 [ElFocus] 小部件
  static FocusNode? focusNode(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_FocusInheritedWidget>()?.focusNode;

  @override
  State<ElFocus> createState() => _ElFocusState();
}

class _ElFocusState extends State<ElFocus>
    with AutomaticKeepAliveClientMixin<ElFocus> {
  final FocusNode focusNode = FocusNode();
  bool hasFocusDepend = false;
  bool hasFocusVisibleDepend = false;

  bool _isFocus = false;

  set isFocus(bool value) {
    if (hasFocusDepend) {
      if (_isFocus != value) {
        setState(() {
          _isFocus = value;
        });
      }
    }
  }

  bool _isFocusVisible = false;

  set isFocusVisible(bool value) {
    if (hasFocusVisibleDepend) {
      if (_isFocusVisible != value) {
        setState(() {
          _isFocusVisible = value;
        });
      }
    }
  }

  bool _lock = false;

  void setFocusDepend() {
    hasFocusDepend = true;
  }

  void setFocusVisibleDepend() {
    hasFocusVisibleDepend = true;
  }

  void focusListener() {
    if (focusNode.hasFocus) {
      isFocus = true;
      if (!_lock) isFocusVisible = true;
    } else {
      isFocus = false;
      isFocusVisible = false;
    }
    _lock = false;
    updateKeepAlive();
  }

  /// 通过 [ElEvent] 事件设置的焦点，需要锁定 [_isFocusVisible] 变量的修改
  void setFocusForEvent() {
    _lock = true;
    focusNode.requestFocus();
  }

  /// 得到焦点的小部件需要保留状态，防止在按需加载过程中被销毁
  @override
  bool get wantKeepAlive => focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(focusListener);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final $data = ElEventTheme.of(context);

    return Focus(
      focusNode: focusNode,
      autofocus: widget.autofocus ?? $data.autofocus ?? false,
      skipTraversal: widget.skipTraversal,
      canRequestFocus: (widget.disabled ?? $data.disabled ?? false) == false,
      child: _FocusInheritedWidget(
        focusNode,
        _isFocus,
        _isFocusVisible,
        setFocusDepend,
        setFocusVisibleDepend,
        setFocusForEvent,
        child: widget.child,
      ),
    );
  }
}
