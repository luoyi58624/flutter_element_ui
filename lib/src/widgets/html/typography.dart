import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../components/basic/text.dart';

// ===========================================================================
// 模拟 Html 排版标签
// ===========================================================================

class H1 extends ElText {
  /// 一级标题
  const H1(super.data, {super.key, super.style}) : super(semanticsLabel: 'H1');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontSize: 2.rem, fontWeight: FontUtil.bold);
  }
}

class H2 extends ElText {
  /// 二级标题
  const H2(super.data, {super.key, super.style}) : super(semanticsLabel: 'H2');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontSize: 1.5.rem, fontWeight: FontUtil.bold);
  }
}

class H3 extends ElText {
  /// 三级标题
  const H3(super.data, {super.key, super.style}) : super(semanticsLabel: 'H3');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontSize: 1.25.rem, fontWeight: FontUtil.bold);
  }
}

class H4 extends ElText {
  /// 四级标题
  const H4(super.data, {super.key, super.style}) : super(semanticsLabel: 'H4');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontSize: 1.17.rem, fontWeight: FontUtil.bold);
  }
}

class H5 extends ElText {
  /// 五级标题
  const H5(super.data, {super.key, super.style}) : super(semanticsLabel: 'H5');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontSize: 1.rem, fontWeight: FontUtil.bold);
  }
}

class H6 extends ElText {
  /// 六级标题
  const H6(super.data, {super.key, super.style}) : super(semanticsLabel: 'H6');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontSize: 0.875.rem, fontWeight: FontUtil.bold);
  }
}

class P extends ElText {
  /// 普通段落文本
  const P(super.data, {super.key, super.style}) : super(semanticsLabel: 'P');
}

class B extends ElText {
  /// 加粗文本
  const B(super.data, {super.key, super.style}) : super(semanticsLabel: 'B');

  @override
  TextStyle? get textStyle {
    return TextStyle(fontWeight: FontUtil.bold);
  }
}

class I extends ElText {
  /// 斜体文本
  const I(super.data, {super.key, super.style}) : super(semanticsLabel: 'I');

  @override
  TextStyle? get textStyle {
    return const TextStyle(fontStyle: FontStyle.italic);
  }
}

class Del extends ElText {
  /// 删除线文本
  const Del(super.data, {super.key, super.style})
      : super(semanticsLabel: 'Del');

  @override
  TextStyle? get textStyle {
    return const TextStyle(decoration: TextDecoration.lineThrough);
  }
}
