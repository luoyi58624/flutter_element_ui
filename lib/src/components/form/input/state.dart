part of 'input.dart';

class ElInputState extends ElModelValueState<ElInput, String> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController(text: modelValue);
  final focusNode = FocusNode();

  late _InputStyleProp _styleProp;

  bool get isRound => widget.round;

  ElFormData? get formData => ElForm.of(context);

  ElFormItemData? get formItemData => ElFormItem.of(context);

  /// 判断当前输入框是否由[ElForm]控制
  bool get useFormDataModel =>
      formItemData != null && formItemData!.prop != null;

  Widget buildTextField(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(
        color: context.elTheme.textColor,
        fontSize: el.config.textStyle.fontSize,
      ),
      decoration: _buildInputDecoration(context),
      textInputAction: widget.textInputAction,
      cursorColor: context.elTheme.textColor,
      cursorWidth: 1,
      onChanged: (v) {
        modelValue = v;
        if (useFormDataModel) {
          formData!.model[formItemData!.prop!] = v;
        }
      },
    );
  }

  @override
  Widget builder(BuildContext context, String value) {
    if (controller.text != value) {
      controller.value = controller.value.copyWith(
        text: modelValue,
      );
    }
    if (useFormDataModel) {
      controller.text = formData!.model[formItemData!.prop];
    }
    final defaultStyle = el.config.inputStyle;
    final $height = widget.height ?? defaultStyle.height;
    _styleProp = (
      height: $height,
      borderRadius: isRound
          ? BorderRadius.circular($height / 2)
          : (widget.borderRadius ??
              defaultStyle.borderRadius ??
              el.config.radius),
      margin: widget.margin ?? defaultStyle.margin,
      padding: widget.padding ??
          (widget.round == true
              ? EdgeInsets.symmetric(horizontal: $height / 2)
              : defaultStyle.padding),
    );
    return Container(
      height: _styleProp.height,
      margin: _styleProp.margin,
      child: Theme(
        data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: context.elTheme.primary.withAlpha(100),
            selectionHandleColor: context.elTheme.primary,
          ),
        ),
        child: HoverBuilder(
          builder: (context) => buildTextField(context),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: _styleProp.padding,
      enabledBorder: OutlineInputBorder(
        borderRadius: _styleProp.borderRadius,
        borderSide: BorderSide(
          width: HoverBuilder.of(context) ? 1.2 : 1,
          color: HoverBuilder.of(context)
              ? context.elTheme.borderHoverColor
              : context.elTheme.borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _styleProp.borderRadius,
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
