part of 'index.dart';

const _duration = Duration(milliseconds: 250);
const _curve = Curves.easeInOut;

class _ElSwitchState extends ElModelValueState<ElSwitch, bool>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;
  bool _isInitial = true;

  double get containerHeight => widget.size + widget.gap;

  double get containerWidth => widget.width ?? containerHeight * 2;

  double get disabledOpacity => widget.disabled ? 0.5 : 1.0;

  Color get activeColor => widget.activeColor ?? Colors.white;

  Color get inactiveColor => widget.color ?? Colors.white;

  Color get activeBgColor => (widget.activeBgColor ?? context.elTheme.primary)
      .withOpacity(disabledOpacity);

  Color get inactiveBgColor => (widget.bgColor ?? context.elTheme.colors.border)
      .withOpacity(disabledOpacity);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      value: modelValue ? 1.0 : 0.0,
      duration: _duration,
    );
    final offset = containerWidth / 2 - containerHeight / 2;
    animation = Tween(begin: -offset, end: offset).animate(CurvedAnimation(
      parent: controller,
      curve: _curve,
    ));
  }

  @override
  void didUpdateWidget(covariant ElSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.size != widget.size ||
        oldWidget.width != widget.width ||
        oldWidget.gap != widget.gap) {
      final offset = containerWidth / 2 - containerHeight / 2;
      animation = Tween(begin: -offset, end: offset).animate(controller);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget builder(BuildContext context, bool value) {
    if (_isInitial) {
      _isInitial = false;
    } else {
      value ? controller.forward() : controller.reverse();
    }
    return GestureDetector(
      onTap: widget.disabled
          ? null
          : () {
              modelValue = !value;
              HapticFeedback.mediumImpact();
            },
      child: ElHoverBuilder(
        disabled: widget.disabled,
        cursor: SystemMouseCursors.click,
        builder: (context) {
          return AnimatedContainer(
            duration: context.elThemeDuration ?? _duration,
            curve: context.elThemeCurve ?? _curve,
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              color: value ? activeBgColor : inactiveBgColor,
              borderRadius: BorderRadius.circular(containerHeight / 2),
            ),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.translate(
                offset: Offset(animation.value, 0),
                child: UnconstrainedBox(
                  child: AnimatedContainer(
                    duration: context.elThemeDuration ?? _duration,
                    curve: context.elThemeCurve ?? _curve,
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: value ? activeColor : inactiveColor,
                      borderRadius: BorderRadius.circular(widget.size / 2),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
