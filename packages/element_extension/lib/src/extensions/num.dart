import 'package:flutter/widgets.dart';
import 'package:element_plus/element_plus.dart';

extension ElFontNumExtension on num {
  /// 以全局字体尺寸为基点，按比例返回新的字体大小，它的实际效果完全等同于 css 中的 rem，
  /// 假设全局字体尺寸为 16 像素:
  /// * 1.rem(context) = 16
  /// * 0.875.rem(context) = 14
  /// * 1.125.rem(context) = 18
  /// * 1.5.rem(context) = 24
  // 必须传递当前组件的 context，因为这样才能绑定依赖关系，否则当全局字体尺寸发生变化时，目标小部件是不会刷新的
  double rem(BuildContext context) {
    assert(ElApp.of(context).textStyle.fontSize != null);
    return ElApp.of(context).textStyle.fontSize! * this;
  }
}
