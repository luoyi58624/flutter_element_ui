part of 'index.dart';

class _ElFocusState extends State<ElFocus> {
  final FocusNode focusNode = FocusNode();

  bool hasFocusDepend = false;

  final _isFocus = BaseObs(false);

  bool get isFocus => _isFocus.value;

  set isFocus(bool value) {
    if (hasFocusDepend) _isFocus.value = value;
  }

  void setFocusDepend() {
    hasFocusDepend = true;
  }

  void focusListener() {
    if (focusNode.hasFocus) {
      isFocus = true;
    } else {
      isFocus = false;
    }
  }

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
    final $data = ElEventTheme.of(context);
    // FocusableActionDetector();
    // IconButton();
    return Focus(
      // onKeyEvent: (node, event) {
      //   // i(event.logicalKey == LogicalKeyboardKey.tab);
      //   i(event);
      //   return KeyEventResult.ignored;
      // },
      focusNode: focusNode,
      autofocus: widget.autofocus ?? $data.autofocus ?? false,
      canRequestFocus: (widget.disabled ?? $data.disabled ?? false) == false,
      child: ObsBuilder(builder: (context) {
        return _FocusInheritedWidget(
          focusNode,
          isFocus,
          setFocusDepend,
          child: widget.child,
        );
      }),
    );
  }
}

class _FocusInheritedWidget extends InheritedWidget {
  const _FocusInheritedWidget(
    this.focusNode,
    this.isFocus,
    this.setFocusDepend, {
    required super.child,
  });

  final FocusNode focusNode;
  final bool isFocus;
  final VoidCallback setFocusDepend;

  static _FocusInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_FocusInheritedWidget>();

  static bool getFocusStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setFocusDepend();
    return result?.isFocus ?? false;
  }

  @override
  bool updateShouldNotify(_FocusInheritedWidget oldWidget) {
    return isFocus != oldWidget.isFocus;
  }
}
