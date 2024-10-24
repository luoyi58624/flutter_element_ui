import 'package:element_extension/src/extensions/num.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

// ===========================================================================
// 模拟 Html 排版标签
// ===========================================================================

class H1 extends ElText {
  /// 一级标题
  const H1(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'H1');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontSize: 2.rem(context), fontWeight: ElFont.bold);
  }
}

class H2 extends ElText {
  /// 二级标题
  const H2(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'H2');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontSize: 1.5.rem(context), fontWeight: ElFont.bold);
  }
}

class H3 extends ElText {
  /// 三级标题
  const H3(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'H3');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontSize: 1.25.rem(context), fontWeight: ElFont.bold);
  }
}

class H4 extends ElText {
  /// 四级标题
  const H4(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'H4');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontSize: 1.125.rem(context), fontWeight: ElFont.bold);
  }
}

class H5 extends ElText {
  /// 五级标题
  const H5(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'H5');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontSize: 1.rem(context), fontWeight: ElFont.bold);
  }
}

class H6 extends ElText {
  /// 六级标题
  const H6(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'H6');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontSize: 0.875.rem(context), fontWeight: ElFont.bold);
  }
}

class P extends ElText {
  /// 普通段落文本
  const P(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'P');
}

class B extends ElText {
  /// 加粗文本
  const B(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'B');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return TextStyle(fontWeight: ElFont.bold);
  }
}

class I extends ElText {
  /// 斜体文本
  const I(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'I');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return const TextStyle(fontStyle: FontStyle.italic);
  }
}

class Del extends ElText {
  /// 删除线文本
  const Del(super.data, {super.key, super.style, super.duration})
      : super(semanticsLabel: 'Del');

  @override
  TextStyle? buildDefaultTextStyle(BuildContext context) {
    return const TextStyle(decoration: TextDecoration.lineThrough);
  }
}
