import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

import '../button/index.dart';

part 'raw_button.dart';

part 'button.dart';

part 'outline_button.dart';

part '../../../generates/components/basic/button2/index.g.dart';

extension _ButtonColorExtension on Color {
  /// 悬停状态颜色，颜色会变得更浅
  Color hover(BuildContext context, [bool? reverse]) =>
      elLight3(context, reverse: reverse ?? false);

  /// 按下状态颜色，颜色会变得更深
  Color tap(BuildContext context, [bool? reverse]) =>
      elLight3(context, reverse: reverse == null ? true : !reverse);

  /// 禁用状态颜色
  Color disabled(BuildContext context) => elLight5(context);
}
