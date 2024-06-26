import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../basic/text.dart';

part 'radio_group.dart';

class ElRadio<T> extends StatelessWidget {
  const ElRadio({
    super.key,
    required this.label,
    required this.value,
    this.disabled = false,
  });

  /// 单选框标签
  final String label;

  /// 单选框的值
  final T value;

  /// 是否禁用当前单选框
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final $data = _ElRadioGroupInheritedWidget.of<T>(context);
    final $value = value ?? (label as T);
    final $primaryColor = context.elTheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.8,
            child: Radio<T>(
              value: $value,
              groupValue: $data.value,
              onChanged: $data.onChanged,
              activeColor: $primaryColor,
              splashRadius: 0,
            ),
          ),
          GestureDetector(
            onTap: () {
              if ($data.onChanged != null) $data.onChanged!($value);
            },
            child: HoverBuilder(builder: (isHover) {
              return ElText(
                label,
                style: TextStyle(
                  color: $value == $data.value ? $primaryColor : null,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
