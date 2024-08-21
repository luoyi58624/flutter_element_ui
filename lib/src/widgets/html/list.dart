import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../components/basic/text.dart';

abstract class _ListBase extends StatelessWidget {
  const _ListBase({super.key});
}

abstract class _ListBoxBase extends _ListBase {
  const _ListBoxBase({
    super.key,
    required this.listType,
    required this.children,
    required this.listStyleType,
    this.gap = 2,
    this.nestGap = 16,
  })  : assert(gap >= 0),
        assert(nestGap >= 0);

  final _ListType listType;

  /// 列表子元素集合，只接受 Ul、Ol、Li 三种 Widget 类型
  final List<_ListBase> children;

  /// 列表样式类型
  final ListStyleType listStyleType;

  /// 列表前缀和内容之间的间距
  final double gap;

  /// 嵌套列表距离上一个列表的间距
  final double nestGap;

  @override
  Widget build(BuildContext context) {
    final $data = _ListInheritedWidget.maybeOf(context);
    int recordNoCommonList = 0;
    Widget result = Column(
      mainAxisSize: MainAxisSize.min,
      children: children.mapIndexed((i, e) {
        if (children[i] is Li) {
          return ChildIndexData(
            index: i - recordNoCommonList,
            length: children.length - recordNoCommonList,
            child: e,
          );
        } else {
          recordNoCommonList++;
          return e;
        }
      }).toList(),
    );

    double $currentGapSize = _calcCurrentGapSize();
    if ($data != null) {
      result = Padding(
        padding: EdgeInsets.only(left: $currentGapSize + nestGap),
        child: result,
      );
    }
    return _ListInheritedWidget(
      listType,
      listStyleType,
      gap,
      $currentGapSize,
      child: result,
    );
  }

  double _calcCurrentGapSize() {
    double gap = 16;
    if (listType == _ListType.ol) {
      if (listStyleType == ListStyleType.decimal) {
        int maxNumber = (this as Ol).start + children.length - 1;
        // 从100开始，每增加一位数便增加10像素尺寸
        if (maxNumber >= 100) {
          gap = 10 * (maxNumber.toString().length - 3) + 32;
        } else if (maxNumber >= 10) {
          gap = 24;
        }
      }
    }
    return gap;
  }
}

class Ul extends _ListBoxBase {
  /// Html 无序列表
  const Ul({
    super.key,
    required super.children,
    super.listStyleType = ListStyleType.disc,
    super.gap,
    super.nestGap,
  }) : super(listType: _ListType.ul);
}

class Ol extends _ListBoxBase {
  /// Html 有序列表
  const Ol({
    super.key,
    required super.children,
    super.listStyleType = ListStyleType.decimal,
    super.gap,
    super.nestGap,
    this.start = 1,
  }) : super(listType: _ListType.ol);

  /// 开始索引，当 listStyleType 是阿拉伯数字时生效
  final int start;

  @override
  Widget build(BuildContext context) {
    return _OlInheritedWidget(
      start,
      child: super.build(context),
    );
  }
}

class Li extends _ListBase {
  /// Html 列表子元素
  const Li({super.key, required this.child});

  final dynamic child;

  @override
  Widget build(BuildContext context) {
    final $data = _ListInheritedWidget.of(context);
    late Widget result = child is Widget ? child : ElText(child);
    Widget? prefix = _buildPrefix(context);
    if (prefix != null) {
      result = Row(
        children: [
          prefix,
          Gap($data.gap),
          Expanded(child: result),
        ],
      );
    } else {
      result = Align(
        alignment: Alignment.centerLeft,
        child: result,
      );
    }
    return result;
  }

  final double _listStyleSize = 6;

  Widget? _buildPrefix(BuildContext context) {
    final $data = _ListInheritedWidget.of(context);
    final $indexData = ChildIndexData.of(context);
    if ($data.listStyleType == ListStyleType.none) return null;
    if ($data.listType == _ListType.ul) {
      late BoxDecoration decoration;
      if ($data.listStyleType == ListStyleType.disc) {
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(_listStyleSize / 2),
          color: context.isDark ? Colors.white : Colors.black,
        );
      } else if ($data.listStyleType == ListStyleType.circle) {
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(_listStyleSize / 2),
          border: Border.all(
            color: context.isDark ? Colors.white : Colors.black,
          ),
        );
      } else if ($data.listStyleType == ListStyleType.square) {
        decoration = BoxDecoration(
          color: context.isDark ? Colors.white : Colors.black,
        );
      }
      return SizedBox(
        width: $data.currentGapSize,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: $data.gap),
            child: Container(
              width: _listStyleSize,
              height: _listStyleSize,
              decoration: decoration,
            ),
          ),
        ),
      );
    } else {
      if ($data.listStyleType == ListStyleType.decimal) {
        final $olData = _OlInheritedWidget.of(context);
        return SizedBox(
          width: $data.currentGapSize,
          child: Align(
            alignment: Alignment.centerRight,
            child: ElText(
              '${$olData.start + $indexData.index}.',
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        );
      }
    }
    return null;
  }
}

enum _ListType { ul, ol }

enum ListStyleType {
  /// 无样式
  none,

  /// 实心圆，无序列表默认样式
  disc,

  /// 空心圆
  circle,

  /// 实心方块
  square,

  /// 阿拉伯数字，有序列表默认样式
  decimal,
}

class _ListInheritedWidget extends InheritedWidget {
  const _ListInheritedWidget(
    this.listType,
    this.listStyleType,
    this.gap,
    this.currentGapSize, {
    required super.child,
  });

  final _ListType listType;
  final ListStyleType listStyleType;
  final double gap;
  final double currentGapSize;

  static _ListInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ListInheritedWidget>();

  static _ListInheritedWidget of(BuildContext context) {
    final _ListInheritedWidget? result = maybeOf(context);
    assert(result != null, 'No _ListInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ListInheritedWidget oldWidget) => true;
}

class _OlInheritedWidget extends InheritedWidget {
  const _OlInheritedWidget(
    this.start, {
    required super.child,
  });

  final int start;

  static _OlInheritedWidget of(BuildContext context) {
    final _OlInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_OlInheritedWidget>();
    assert(result != null, 'No _OlInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_OlInheritedWidget oldWidget) => true;
}
