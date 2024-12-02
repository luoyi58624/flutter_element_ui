import 'package:element_plus/element_plus.dart';

extension ElFontNumExtension on num {
  /// 以全局字体尺寸为基点，按比例返回新的字体大小，假设全局字体尺寸为 16 像素:
  /// * 1.rem = 16
  /// * 0.875.rem = 14
  /// * 1.125.rem = 18
  /// * 1.5.rem = 24
  double get rem {
    return el.context.elTheme.textTheme.textStyle.fontSize! * this;
  }
}
