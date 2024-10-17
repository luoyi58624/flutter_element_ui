import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

import '../form.dart';
import '../form_item.dart';

part 'state.dart';

part 'style.dart';

part '../../../generates/components/form/input/index.g.dart';

typedef _InputStyleProp = ({
  double height,
  BorderRadius borderRadius,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
});

class ElInput extends ModelValue<String> {
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
    this.minLines,
    this.maxLines = 1,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
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

  /// 最小行
  final int? minLines;

  /// 最大行
  final int? maxLines;

  /// 输入框文本样式
  final TextStyle? textStyle;

  /// 前缀图标
  final ElIcon? prefixIcon;

  /// 后缀图标
  final ElIcon? suffixIcon;

  /// 输入框提示文本
  final String? placeholder;

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
