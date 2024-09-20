part of 'index.dart';

class _ElSliderState extends ElModelValueState<ElSlider, double> {
  @override
  Widget builder(BuildContext context, double value) {
    return Stack(
      children: [
        SizedBox(
          height: widget.height,
          child: Center(
            child: Container(
              height: widget.thumbSize,
              color: context.elTheme.sliderStyle.inactiveColor,
            ),
          ),
        ),
        Positioned(
          left: max(value, 0),
          child: GestureDetector(
            onHorizontalDragUpdate: (e) {
              widget.modelValue.value += e.delta.dx;
            },
            onHorizontalDragEnd: (e) {
              widget.modelValue.value = max(value, 0);
            },
            child: Container(
              width: widget.sliderSize,
              height: widget.sliderSize,
              decoration: BoxDecoration(
                color: context.elTheme.sliderStyle.activeColor ??
                    context.elTheme.primary,
                borderRadius: BorderRadius.circular(widget.sliderSize / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
