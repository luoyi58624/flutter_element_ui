import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/utils/util.dart';

/// 更新自定义布局尺寸回调函数，返回一个布尔值，每次构建布局时只有第一次回调才会更新布局，
/// 所以第一次调用会返回true，第二次触发是因为更新布局引起的重建，此时会返回false
typedef ElUpdateCustomLayoutSize = void Function(Size size);

class ElCustomMultiChildLayout extends StatefulWidget {
  /// 简单地扩展自定义多子组件布局，[CustomMultiChildLayout] 只能预先设置父级盒子的尺寸，
  /// 但有时我们希望先测量所有子元素，再决定父级的大小，这就是该组件的作用，
  /// 唯一的缺点是每次构建它会进行两次 build。
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
    ElUpdateCustomLayoutSize updateSize,
    bool isSecondBuild,
  ) delegateBuilder;

  /// 子组件集合，和 [CustomMultiChildLayout] 一样，你必须使用 [LayoutId] 标识它们
  final List<Widget> children;

  @override
  State<ElCustomMultiChildLayout> createState() =>
      _ElCustomMultiChildLayoutState();
}

class _ElCustomMultiChildLayoutState extends State<ElCustomMultiChildLayout> {
  late Size _size = Size(widget.width, widget.height);

  /// 是否是二次构建，自定义布局会执行 [updateSize] 函数更新父元素的实际大小，
  /// 引起二次重建，此变量的作用是防止重复更新
  bool isSecondBuild = false;

  /// 更新自定义布局尺寸，第一次调用后会进行重建，第二次调用则重置[isSecondBuild]
  void updateSize(Size size) {
    if (isSecondBuild == false) {
      isSecondBuild = true;
      ElUtil.nextTick(() {
        _size = size;
        setState(() {});
      });
    } else {
      isSecondBuild = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size.width,
      height: _size.height,
      child: CustomMultiChildLayout(
        delegate: widget.delegateBuilder(updateSize, isSecondBuild),
        children: widget.children,
      ),
    );
  }
}
