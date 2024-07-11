import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/theme.dart';

import '../../styles/theme.dart';
import '../basic/icon.dart';
import '../others/hover.dart';
import 'form.dart';
import 'form_item.dart';

typedef _InputStyleProp = ({
  double height,
  BorderRadius borderRadius,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
});

/// Element UI 输入框组件
class ElInput extends StatefulWidget {
  const ElInput({
    super.key,
    this.value,
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
    this.onChanged,
    this.onTap,
    this.onClean,
    this.onValidator,
    this.onSuffixIcon,
  });

  /// input输入框内容，当它发生改变时会实时同步到Input
  final String? value;

  /// 自定义输入框控制器
  final TextEditingController? controller;

  /// 输入框高度
  final double? height;

  /// 自定义圆角，如果[round]为true，则强制圆角
  final BorderRadiusGeometry? borderRadius;

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

  /// 内容更新回调
  final ValueChanged<String>? onChanged;

  /// 点击输入框回调
  final GestureTapCallback? onTap;

  /// 点击清除回调
  final GestureTapCallback? onClean;

  /// 表单校验回调
  final FormFieldValidator<String>? onValidator;

  /// 点击自定义后缀图标回调
  final GestureTapCallback? onSuffixIcon;

  @override
  State<ElInput> createState() => _ElInputState();
}

class _ElInputState extends State<ElInput> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController(text: widget.value);
  final focusNode = FocusNode();

  ElConfigData get elConfig => context.elConfig;

  get defaultStyle => elConfig.inputStyle;

  bool get isRound => widget.round;

  ElFormData? get formData => ElForm.of(context);

  ElFormItemData? get formItemData => ElFormItem.of(context);

  /// 判断当前输入框是否由[ElForm]控制
  bool get useFormDataModel =>
      widget.value == null &&
      formItemData != null &&
      formItemData!.prop != null;

  @override
  void didUpdateWidget(covariant ElInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final String newText = widget.value ?? '';
      controller.value = controller.value.copyWith(
        text: newText,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (useFormDataModel) {
      controller.text = formData!.model[formItemData!.prop];
    }
    final $height = widget.height ?? defaultStyle.height;
    _InputStyleProp styleProp = (
      height: $height,
      borderRadius: isRound
          ? BorderRadius.circular($height / 2)
          : (widget.borderRadius ??
              defaultStyle.borderRadius ??
              BorderRadius.circular(elConfig.radius)),
      margin: widget.margin ?? defaultStyle.margin,
      padding: widget.padding ??
          (widget.round == true
              ? EdgeInsets.symmetric(horizontal: $height / 2)
              : defaultStyle.padding),
    );
    return Container(
      height: styleProp.height,
      margin: styleProp.margin,
      child: Theme(
        data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: context.elTheme.primary.withAlpha(100),
            selectionHandleColor: context.elTheme.primary,
          ),
        ),
        child: ElHover(
          builder: (isHover) {
            return Builder(builder: (context) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                style: TextStyle(
                  color: context.elTheme.textColor,
                  fontSize: context.elConfig.fonSize,
                ),
                decoration: _buildInputDecoration(context, styleProp),
                textInputAction: widget.textInputAction,
                cursorColor: context.elTheme.textColor,
                cursorWidth: 1,
                onChanged: (v) {
                  if (useFormDataModel) {
                    formData!.model[formItemData!.prop!] = v;
                  }
                  if (widget.onChanged != null) widget.onChanged!(v);
                },
              );
            });
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    BuildContext context,
    _InputStyleProp styleProp,
  ) {
    return InputDecoration(
      contentPadding: styleProp.padding,
      enabledBorder: OutlineInputBorder(
        borderRadius: styleProp.borderRadius,
        borderSide: BorderSide(
          width: ElHover.of(context) ? 1.2 : 1,
          color: ElHover.of(context)
              ? context.elTheme.borderHoverColor
              : context.elTheme.borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: styleProp.borderRadius,
        borderSide: BorderSide(
          width: 2,
          color: context.elTheme.primary,
        ),
      ),
      // suffixIcon: currentValue != ''
      //     ? GestureDetector(
      //   onTap: () {
      //     FlutterUtil.unFocus();
      //     controller.clear();
      //     setState(() {
      //       currentValue = '';
      //     });
      //     if (widget.onSearch != null) widget.onSearch!('');
      //   },
      //   child: const Icon(
      //     Icons.clear,
      //     size: 18,
      //   ),
      // )
      //     : null,
    );
  }
}
