part of '../event.dart';

mixin _FocusMixin<T extends ElEvent> on _CommonMixin<T> {
  /// 焦点组节点对象，如果使用 [ElFocusScope]，那么它将初始化
  FocusScopeNode? focusScopeNode;

  /// 如果存在 [Focus] 焦点小部件，那么它将被初始化
  FocusNode? focusNode;

  /// 保存 [ElFocusScope] 小部件实例，用于设置指针按下时的焦点
  _FocusScopeInheritedWidget? _focusScopeWidget;

  _FocusScopeInheritedWidget? get focusScopeWidget => _focusScopeWidget;

  set focusScopeWidget(_FocusScopeInheritedWidget? value) {
    if (value != null) {
      _focusScopeWidget = value;
      focusScopeNode = FocusScope.of(context, createDependency: false);
    } else {
      _focusScopeWidget = null;
      focusScopeNode = null;
    }
  }

  /// 是否存在焦点状态依赖，如果没有依赖需要防止不必要的重新渲染
  bool hasFocusDepend = false;

  final _hasFocus = Obs(false);

  /// 焦点状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool get hasFocus => _hasFocus.value;

  set hasFocus(bool value) {
    if (hasFocusDepend) _hasFocus.value = value;
  }

  void setFocusDepend() {
    hasFocusDepend = true;
  }

  void _requestFocus() {
    if (_focusScopeWidget != null && focusScopeNode!.hasFocus == false) {
      if (focusNode?.canRequestFocus == true) focusNode?.requestFocus();
    }
  }

  Widget buildFocusWidget(BuildContext context, Widget child) {
    focusScopeWidget = _FocusScopeLookupBoundary.getWidget(context);
    if (focusScopeWidget != null) {
      // 创建 ElFocusScope 隔离边界，防止嵌套 ElEvent 小部件重复创建 Focus 焦点，
      // 这么做的目的是：只有当用户使用了 ElFocusScope 小部件，下面 ElEvent 才会创建焦点，
      // 同时，如果 ElEvent 嵌套 ElEvent，内部 ElEvent 要想获得焦点就必须再次插入 ElFocusScope。
      return _FocusScopeLookupBoundary(
        child: Focus(
          autofocus: prop.autofocus,
          canRequestFocus: prop.canRequestFocus,
          child: Builder(builder: (context) {
            focusNode = Focus.of(context);
            hasFocus = focusNode!.hasFocus;
            return child;
          }),
        ),
      );
    } else {
      return child;
    }
  }
}
