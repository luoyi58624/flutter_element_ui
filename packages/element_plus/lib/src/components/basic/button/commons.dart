part of 'index.dart';

extension _ButtonColorExtension on Color {
  /// 悬停状态颜色，颜色会变得更浅
  Color hover(BuildContext context) => elLight3(context);

  /// 按下状态颜色，颜色会变得更深
  Color tap(BuildContext context) => elLight3(context, reverse: true);

  /// 禁用状态颜色
  Color disabled(BuildContext context) => elLight5(context);

  /// 链接悬停状态文字颜色
  Color linkTextHover(BuildContext context) => elLight5(context);

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
