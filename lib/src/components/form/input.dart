import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

typedef _InputStyleProp = ({
  double height,
  BorderRadiusGeometry borderRadius,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
});

/// Element UI 输入框组件
/// ```dart
/// ElInput(
///   value: inputValue,
///   onChanged: (v) => setState(() => inputValue = v),
/// ),
/// ```
class ElInput extends StatefulWidget {
  const ElInput({
    super.key,
    this.value,
    this.controller,
    this.height,
    this.borderRadius,
    this.margin,
    this.padding,
    this.onChanged,
  });

  /// input输入框内容，当它发生改变时会实时同步到Input
  final String? value;

  /// 自定义输入框控制器
  final TextEditingController? controller;

  /// 输入框高度
  final double? height;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 自定义外边距
  final EdgeInsetsGeometry? margin;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 监听输入框内容更新事件
  final ValueChanged<String>? onChanged;

  @override
  State<ElInput> createState() => _ElInputState();
}

class _ElInputState extends State<ElInput> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController(text: widget.value);
  final focusNode = FocusNode();

  get elConfig => context.elConfig;

  get defaultStyle => elConfig.inputStyle;

  _InputStyleProp get styleProp => (
        height: widget.height ?? defaultStyle.height,
        borderRadius: widget.borderRadius ??
            defaultStyle.borderRadius ??
            BorderRadius.circular(elConfig.radius),
        margin: widget.margin ?? defaultStyle.margin,
        padding: widget.padding ?? defaultStyle.padding,
      );

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
        child: HoverBuilder(
          builder: (isHover) {
            return Builder(builder: (context) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                style: TextStyle(
                  color: context.elTheme.textColor,
                  fontSize: context.elConfig.fonSize,
                ),
                decoration: _buildInputDecoration(context),
                cursorColor: context.elTheme.textColor,
                cursorWidth: 1,
                onChanged: (v) {
                  if (widget.onChanged != null) widget.onChanged!(v);
                },
              );
            });
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: styleProp.padding,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: HoverBuilder.of(context) ? 1.2 : 1,
          color: HoverBuilder.of(context)
              ? context.elTheme.borderHoverColor
              : context.elTheme.borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
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
