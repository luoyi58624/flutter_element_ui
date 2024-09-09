import '../utils/font.dart';

extension ElFontExtension on num {
  /// 以全局字体尺寸为基点，按比例返回新的字体大小
  double get rem => ElFont.globalFontSize * this;
}