import '../app.dart';
import '../utils/font.dart';

extension ElFontExtension on num {
  /// 以全局字体尺寸为基点，按比例返回新的字体大小，它的实际效果完全等同于 css 中的 rem，
  /// 假设全局字体尺寸为 16 像素:
  /// * 1.rem = 16
  /// * 0.875.rem = 14
  /// * 1.125.rem = 18
  /// * 1.5.rem = 24
  ///
  /// 但是请注意使用时机，它不仅依赖于 [ElApp] 注入的全局配置，还依赖 Element UI 全局 context，
  /// 如果出现错误请根据报错信息检查配置是否正确。
  double get rem => ElFont.globalFontSize * this;
}
