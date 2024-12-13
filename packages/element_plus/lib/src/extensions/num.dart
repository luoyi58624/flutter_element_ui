import 'package:flutter/widgets.dart';

import '../global.dart';

extension ElNumExtension on num {
  double elFontScale(BuildContext context) {
    final scale = context.commonSizePreset.fontScale!;
    return (scale + (1.0 - scale) / 2) * this;
  }
}
