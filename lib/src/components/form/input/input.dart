import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../../services/service.dart';
import '../../../widgets/model_value.dart';
import '../../basic/icon.dart';
import '../form.dart';
import '../form_item.dart';

part 'state.dart';

typedef _InputStyleProp = ({
  double height,
  BorderRadius borderRadius,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
});

/// Flutter 输入框非常复杂，如果基于 [EditableText] 实现需要实现大量兼容性代码，
/// 而 [TextField] 本身已经做了很多兼容处理，所以 [ElInput] 是直接基于 [TextField] 实现
class ElInput extends ElModelValue<String> {
  /// Element UI 输入框组件
  const ElInput(
    super.modelValue, {
    super.key,
    super.onChanged,
    this.controller,
    this.height,
    this.borderRadius,
    this.margin,
    this.padding,
    this.round = false,
    this.disabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.onTap,
    this.onClean,
    this.onValidator,
    this.onSuffixIcon,
  });

  /// 自定义输入框控制器
  final TextEditingController? controller;

  /// 输入框高度
  final double? height;

  /// 自定义圆角，如果[round]为true，则强制圆角
  final BorderRadius? borderRadius;

  /// 自定义外边距
  final EdgeInsetsGeometry? margin;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 圆角边框
  final bool round;

  /// 是否禁用
  final bool disabled;

  /// 前缀图标
  final ElIcon? prefixIcon;

  /// 后缀图标
  final ElIcon? suffixIcon;

  /// 输入法控件执行的操作: none、done、search、send、next...
  final TextInputAction? textInputAction;

  /// 点击输入框回调
  final GestureTapCallback? onTap;

  /// 点击清除回调
  final GestureTapCallback? onClean;

  /// 表单校验回调
  final FormFieldValidator<String>? onValidator;

  /// 点击自定义后缀图标回调
  final GestureTapCallback? onSuffixIcon;

  @override
  State<ElInput> createState() => ElInputState();
}
