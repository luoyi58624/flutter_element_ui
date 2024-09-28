import 'package:flutter/widgets.dart';

import '../global.dart';

/// 更新自定义布局尺寸回调函数
typedef UpdateCustomLayoutSize = void Function(Size size);

class CustomMultiChildLayoutWidget extends StatefulWidget {
  /// 简单地扩展自定义多子组件布局，[CustomMultiChildLayout] 只能预先设置父级盒子的尺寸，
  /// 但有时我们希望先测量所有子元素，再决定父级的大小，这就是该组件的作用
  const CustomMultiChildLayoutWidget({
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

  /// 处理多个子部件布局逻辑，在此基础上传递了两个参数：
  /// * 更新父盒子尺寸函数
  /// * 是否是第二次重建，更新尺寸需要刷新一次布局，所以会引起一次重新构建
  final MultiChildLayoutDelegate Function(
    UpdateCustomLayoutSize updateSize,
    bool isReBuild,
  ) delegateBuilder;

  /// 子组件集合，和 [CustomMultiChildLayout] 一样，你必须使用 [LayoutId] 标识它们
  final List<Widget> children;

  @override
  State<CustomMultiChildLayoutWidget> createState() =>
      _CustomMultiChildLayoutWidgetState();
}

class _CustomMultiChildLayoutWidgetState
    extends State<CustomMultiChildLayoutWidget> {
  late Size _size = Size(widget.width, widget.height);

  /// 是否是二次重建，第一次执行 [updateSize] 函数时会进行一次重建
  bool isReBuild = false;

  /// 更新自定义布局尺寸，第一次调用后会进行重建，第二次调用则重置[isReBuild]
  void updateSize(Size size) {
    if (isReBuild == false) {
      isReBuild = true;
      nextTick(() {
        _size = size;
        setState(() {});
      });
    } else {
      isReBuild = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size.width,
      height: _size.height,
      child: CustomMultiChildLayout(
        delegate: widget.delegateBuilder(updateSize, isReBuild),
        children: widget.children,
      ),
    );
  }
}
