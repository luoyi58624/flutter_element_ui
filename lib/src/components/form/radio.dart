import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/theme.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../basic/typography.dart';

part 'radio_group.dart';

class ElRadio<T> extends StatelessWidget {
  const ElRadio({
    super.key,
    required this.value,
    this.selectedValue,
    this.label,
    this.disabled = false,
    this.onChanged,
  });

  /// 单选框的值
  final T value;

  /// 当[selectedValue]=[value]时，单选框将处于选中状态，如果有一组明确的值，
  /// 推荐使用[ElRadioGroup]
  final T? selectedValue;

  /// 单选框标签
  final String? label;

  /// 是否禁用当前单选框
  final bool disabled;

  /// 选中的值发生变化事件，如果不使用[ElRadioGroup]，又没有设置[onChanged]事件，
  /// 单选框不会自动应用禁用样式，禁用单选框唯一方法就是设置[disabled]属性
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final $data = _ElRadioGroupInheritedWidget.of<T>(context);
    final $selectedValue = selectedValue ?? $data?.value;
    final $onChanged = disabled ? null : (onChanged ?? $data?.onChanged);
    final $value = value ?? (label as T);
    final elTheme = context.elTheme;
    final double disabledColorOpacity = disabled ? 0.5 : 1.0;
    return HoverBuilder(
      disabled: disabled,
      builder: (isHover) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 0.8,
                child: IgnorePointer(
                  ignoring: $data == null && onChanged == null,
                  child: Opacity(
                    opacity: disabledColorOpacity,
                    child: Radio<T>(
                      value: $value,
                      groupValue: $selectedValue,
                      mouseCursor:
                          disabled ? SystemMouseCursors.forbidden : null,
                      onChanged: disabled ? null : ($onChanged ?? (v) {}),
                      activeColor: elTheme.primary,
                      splashRadius: 0,
                    ),
                  ),
                ),
              ),
              if (label != null)
                GestureDetector(
                  onTap: () {
                    if ($onChanged != null) $onChanged($value);
                  },
                  child: ElText(
                    label,
                    style: TextStyle(
                      fontWeight: $value == $selectedValue
                          ? FontWeight.w500
                          : FontWeight.normal,
                      color: disabled
                          ? elTheme.textColor.withOpacity(disabledColorOpacity)
                          : $value == $selectedValue
                              ? elTheme.primary
                              : elTheme.textColor,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
