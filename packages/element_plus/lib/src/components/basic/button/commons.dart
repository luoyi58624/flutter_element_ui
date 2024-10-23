part of 'index.dart';

/// 按钮 background、border 禁用透明度
const double _disabledOpacity = 0.6;

/// 按钮 text 禁用透明度
const double _textDisabledOpacity = 0.36;

/// 主题按钮 text 禁用透明度
const double _themeButtonTextDisabledOpacity = 0.85;

extension _ButtonColorStyleExtension on _ButtonColorStyle {
  _ButtonColorStyle plainButtonDisabled(bool disabled) {
    if (disabled) {
      bgColor = bgColor?.withOpacity(_disabledOpacity);
      textColor = textColor!.withOpacity(_textDisabledOpacity);
      borderColor = borderColor!.withOpacity(_disabledOpacity);
    }
    return this;
  }

  _ButtonColorStyle textButtonDisabled(bool disabled) {
    if (disabled) {
      textColor = textColor!.withOpacity(_textDisabledOpacity);
    }
    return this;
  }

  _ButtonColorStyle linkButtonDisabled(bool disabled) {
    if (disabled) {
      textColor = textColor!.withOpacity(_textDisabledOpacity);
    }
    return this;
  }
}

extension _ButtonColorExtension on Color {
  /// hover 悬停颜色，颜色会变得更浅
  Color hover(BuildContext context) => elLight3(context);

  /// tap 按下颜色，颜色会变得更深
  Color tap(BuildContext context) => elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight6(context);
}

/// 按钮颜色样式
class _ButtonColorStyle {
  Color? bgColor;
  Color? textColor;
  Color? borderColor;
  Color? loadingTextColor;

  _ButtonColorStyle({
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.loadingTextColor,
  });
}

class _ButtonGroupUtil {
  static bool isSelected(dynamic modelValue, int index) {
    // 如果是按钮组，则将选中的值作为悬停状态
    if (modelValue != null) {
      if (modelValue is List) {
        if (modelValue.contains(index)) {
          return true;
        }
      } else if (modelValue == index) {
        return true;
      }
    }

    return false;
  }
}
