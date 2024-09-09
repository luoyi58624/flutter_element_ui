import 'package:flutter/widgets.dart';

import '../app.dart';

extension ElFontExtension on num {
  /// 以全局字体尺寸为基点，按比例返回新的字体大小，它的实际效果完全等同于 css 中的 rem，
  /// 假设全局字体尺寸为 16 像素:
  /// * 1.rem(context) = 16
  /// * 0.875.rem(context) = 14
  /// * 1.125.rem(context) = 18
  /// * 1.5.rem(context) = 24
  ///
  /// 提示：必须传递当前组件的 context，因为这样做才能绑定依赖关系
  double rem(BuildContext context) =>
      ElApp.of(context).textStyle.fontSize! * this;
}
