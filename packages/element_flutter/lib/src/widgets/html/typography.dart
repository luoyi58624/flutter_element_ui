import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

// ===========================================================================
// 模拟 Html 排版标签
// ===========================================================================

class H1 extends ElText {
  /// 一级标题
  H1(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
}

class H2 extends ElText {
  /// 二级标题
  H2(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}

class H3 extends ElText {
  /// 三级标题
  H3(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}

class H4 extends ElText {
  /// 四级标题
  H4(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}

class H5 extends ElText {
  /// 五级标题
  H5(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}

class H6 extends ElText {
  /// 六级标题
  H6(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
}

class P extends ElText {
  /// 普通段落文本
  const P(super.data, {super.key, super.style});
}

class B extends ElText {
  /// 加粗文本
  B(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle = TextStyle(fontWeight: FontWeight.bold);
}

class I extends ElText {
  /// 斜体文本
  I(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle = TextStyle(fontStyle: FontStyle.italic);
}

class Del extends ElText {
  /// 删除线文本
  Del(
    super.data, {
    super.key,
    TextStyle? style,
  }) : super(style: defaultStyle.merge(style));

  static const TextStyle defaultStyle =
      TextStyle(decoration: TextDecoration.lineThrough);
}
