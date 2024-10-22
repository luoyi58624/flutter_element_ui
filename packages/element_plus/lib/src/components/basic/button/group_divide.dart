part of 'index.dart';
/// 按钮组分割线
class _GroupDivide extends StatelessWidget {
  const _GroupDivide({
    required this.modelValue,
    required this.length,
    required this.index,
    required this.hoverIndex,
    required this.borderColor,
  });

  final dynamic modelValue;
  final int length;
  final int index;
  final Obs<int> hoverIndex;
  final Obs<Color?> borderColor;

  bool _isActive(int targetIndex) {
    int $hoverIndex = hoverIndex.value;
    int? activeIndex;
    if (_ButtonGroupUtil.isSelected(modelValue, index)) {
      activeIndex = index;
    }

    if ($hoverIndex == targetIndex) {
      return true;
    }
    if (activeIndex != null && activeIndex == targetIndex) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    final $groupData = _ElButtonGroupInheritedWidget.maybeOf(context)!;
    late final Color $borderColor;
    late final double $width;
    final $height = $data.height ?? context.elConfig.size;

    if ($data.type == null && $data.bgColor == null) {
      $width = 1.0;
      // if (_ButtonGroupUtil.isSelected($groupData.modelValue, index)) {
      //   $borderColor = _ButtonStyleUtil.defaultStyle(
      //     context,
      //     disabled: false,
      //     isHover: true,
      //   ).borderColor!;
      // } else {
      //   $borderColor = context.elTheme.borderColor;
      // }
      $borderColor = context.elTheme.borderColor;
    } else {
      if ($data.plain == true) {
        $width = 1.0;
        $borderColor = _ButtonStyleUtil.plainStyle(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
          disabled: false,
          isHover: false,
          isTap: false,
        ).borderColor!;
      } else {
        $width = 0.5;
        $borderColor = context.isDark
            ? context.lightTheme.bgColor
            : context.elTheme.borderColor;
      }
    }

    return ObsBuilder(
        watch: [hoverIndex],
        builder: (context) {
          Color color = $borderColor;
          int $hoverIndex = hoverIndex.value;

          Color hoverBorderColor = borderColor.value ?? $borderColor;
          if (length == 2) {
            color = $hoverIndex != -1 ? hoverBorderColor : $borderColor;
          } else if (length > 2) {
            if ($hoverIndex == 0) {
              if (index == $hoverIndex) color = hoverBorderColor;
            } else if ($hoverIndex == length - 1) {
              if (index == $hoverIndex - 1) color = hoverBorderColor;
            } else if ($hoverIndex != -1) {
              if (index == $hoverIndex - 1 || index == $hoverIndex) {
                color = hoverBorderColor;
              }
            }
          }

          return AnimatedColoredBox(
            duration: context.elDuration(_duration),
            color: color,
            child: SizedBox(
              width: $width,
              height: $height,
            ),
          );
        });
  }
}

