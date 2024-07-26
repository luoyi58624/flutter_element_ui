// ============================================================================
// 标题小部件不会提供大量的额外配置，如果发现参数不能满足，请直接使用ElText
// ============================================================================

import 'package:flutter/widgets.dart';

import '../../core.dart';
import '../../utils/font.dart';
import 'text.dart';

class H1 extends ElText {
  /// 一级标题
  const H1(super.data, {super.key, super.style}) : super(semanticsLabel: 'H1');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h1,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H2 extends ElText {
  /// 二级标题
  const H2(super.data, {super.key, super.style}) : super(semanticsLabel: 'H2');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h2,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H3 extends ElText {
  /// 三级标题
  const H3(super.data, {super.key, super.style}) : super(semanticsLabel: 'H3');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h3,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H4 extends ElText {
  /// 四级标题
  const H4(super.data, {super.key, super.style}) : super(semanticsLabel: 'H4');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h4,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H5 extends ElText {
  /// 五级标题
  const H5(super.data, {super.key, super.style}) : super(semanticsLabel: 'H5');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h5,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}

class H6 extends ElText {
  /// 六级标题
  const H6(super.data, {super.key, super.style}) : super(semanticsLabel: 'H6');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context)
        .style
        .copyWith(
          fontSize: el.typography.h6,
          fontWeight: ElFont.bold,
        )
        .merge(style);
  }
}
