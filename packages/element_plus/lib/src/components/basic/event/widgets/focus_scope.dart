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

class ElFocusScope extends StatefulWidget {
  const ElFocusScope({
    super.key,
    required this.child,
  });

  const ElFocusScope.exclude({
    super.key,
    required this.child,
  });

  final Widget child;

  /// 焦点组是否得到焦点，当焦点组内部任意一个 Focus 得到焦点时，此变量将为 true
  static bool hasFocus(BuildContext context) =>
      _FocusScopeInheritedWidget.getFocusStatus(context);

  /// 焦点组请求焦点，注意：不要通过 [of] 请求焦点
  static void requestFocus(BuildContext context) {
    // 必须在下一帧访问，否则如果用户在 onTapDown 事件中立即请求焦点时，拿到的是旧数据
    nextTick(() {
      if (context.mounted) {
        final result =
            context.getInheritedWidgetOfExactType<_FocusScopeInheritedWidget>();
        if (result != null) {
          result.focusNode?.requestFocus();
        }
      }
    });
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
    if (hasDepend && mounted) {
      if (_hasFocus != value) {
        setState(() {
          _hasFocus = value;
        });
      }
    }
  }

  /// 内部 [ElFocus] 预设焦点，[ElEvent] 会在指针按下那一瞬间便立即将选中的焦点设置到此变量
  FocusNode? focusNode;

  void setFocusNode(FocusNode? node) {
    if (node != null) focusNode = node;
  }

  void setDepend() {
    hasDepend = true;
  }

  @override
  void initState() {
    super.initState();
    focusScopeNode.addListener(() {
      nextTick(() {
        hasFocus = focusScopeNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusScopeNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: focusScopeNode,
      child: _FocusScopeInheritedWidget(
        _hasFocus,
        setDepend,
        focusScopeNode,
        focusNode,
        setFocusNode,
        child: widget.child,
      ),
    );
  }
}
