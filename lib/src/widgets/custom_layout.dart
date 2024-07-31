import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/utils/util.dart';

typedef ElUpdateSizeCallback = void Function(Size size);

class ElCustomMultiChildLayout extends StatefulWidget {
  /// 简单地扩展自定义多子组件布局，构建自定义布局逻辑时你可以计算父级容器尺寸，它的功能也仅限于此，
  /// 主要作用是实现在滚动容器中对 [CustomMultiChildLayout] 组件进行整体的尺寸测量。
  ///
  /// 提示：如果你的每个子元素尺寸都是固定的，那么你并不需要使用到它，直接计算就行了。
  const ElCustomMultiChildLayout({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    required this.delegateBuilder,
    required this.children,
  });

  /// 预定父盒子的宽度，默认无限，当处于滚动容器中，你必须预先设置它，
  /// 通常情况下，每个子元素应该设置预期的最大宽度，然后根据子元素数量 * 最大宽度
  final double width;

  /// 预定父盒子的高度，默认无限，当处于滚动容器中，你必须预先设置它
  final double height;

  /// 处理多个子部件布局逻辑，在此基础上传递了一个更新父盒子尺寸函数，当你处理完布局逻辑后，
  /// 通过此函数设置父盒子的实际大小
  final MultiChildLayoutDelegate Function(
    ElUpdateSizeCallback updateSize,
  ) delegateBuilder;

  /// 子组件集合，和 [CustomMultiChildLayout] 一样，你必须使用 [LayoutId] 标识它们
  final List<Widget> children;

  @override
  State<ElCustomMultiChildLayout> createState() =>
      _ElCustomMultiChildLayoutState();
}

class _ElCustomMultiChildLayoutState extends State<ElCustomMultiChildLayout> {
  late Size _size = Size(widget.width, widget.height);

  /// 当第一次构建时，自定义布局会执行 [updateSize] 函数更新父元素的实际大小，
  /// 引起二次重建，此变量的作用是防止重复更新
  bool _needLayout = true;

  void updateSize(Size size) {
    if (_needLayout) {
      ElUtil.nextTick(() {
        _size = size;
        _needLayout = false;
        setState(() {});
      });
    } else {
      _needLayout = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size.width,
      height: _size.height,
      child: CustomMultiChildLayout(
        delegate: widget.delegateBuilder(updateSize),
        children: widget.children,
      ),
    );
  }
}
