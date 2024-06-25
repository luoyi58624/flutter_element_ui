import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

typedef _InputStyleProp = ({
  double height,
  BorderRadiusGeometry borderRadius,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
});

class ElInput extends HookWidget {
  const ElInput({
    super.key,
    this.value,
    this.height,
    this.borderRadius,
    this.margin,
    this.padding,
    this.onChanged,
  });

  /// input初始值，你可以传递任意类型的数据，如果传递的是[ValueNotifier]，那么会自动同步
  final dynamic value;

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

  /// 是否是响应式
  bool get isModelValue => value is ValueNotifier;

  @override
  Widget build(BuildContext context) {
    final elConfig = context.elConfig;
    final defaultStyle = elConfig.inputStyle;
    _InputStyleProp styleProp = (
      height: height ?? defaultStyle.height,
      borderRadius: borderRadius ??
          defaultStyle.borderRadius ??
          BorderRadius.circular(elConfig.radius),
      margin: margin ?? defaultStyle.margin,
      padding: padding ?? defaultStyle.padding,
    );
    final textController = useTextEditingController(
        text: value == null ? '' : (isModelValue ? value.value : '$value'));
    final focusNode = useFocusNode();
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
                controller: textController,
                focusNode: focusNode,
                style: TextStyle(
                  color: context.elTheme.textColor,
                  fontSize: context.elConfig.fonSize,
                ),
                decoration: _buildInputDecoration(context, styleProp),
                cursorColor: context.elTheme.textColor,
                cursorWidth: 1,
                onChanged: (v) {
                  if (isModelValue) (value as ValueNotifier).value = v;
                  if (onChanged != null) onChanged!(v);
                },
              );
            });
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context, _InputStyleProp styleProp) {
    return InputDecoration(
      contentPadding: styleProp.padding,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: HoverBuilder.of(context)
              ? context.elTheme.borderHoverColor
              : context.elTheme.borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
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
