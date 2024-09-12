part of '../index.dart';

class _DefaultButton extends StatelessWidget {
  const _DefaultButton({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final $data = _ButtonData.of(context);
    final $primaryColor = context.elTheme.primary;
    final $isTap = context.isTap;
    final $isHover = context.isHover;
    return AnimatedContainer(
      duration: $data.duration,
      // width: width,
      height: $data.height,
      constraints: const BoxConstraints(
        minWidth: _minWidth,
      ),
      padding:
          $data.padding ?? EdgeInsets.symmetric(horizontal: $data.height / 2),
      decoration: BoxDecoration(
        color: $isTap || $isHover ? $primaryColor.themeLightBg(context) : null,
        border: Border.all(
            color: context.isTap
                ? $primaryColor
                : $isHover
                    ? $primaryColor.themeLightBorder(context)
                    : context.elTheme.borderColor,
            width: 1),
        borderRadius: $data.borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
