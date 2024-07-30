import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/utils/util.dart';
import 'package:flutter_obs/flutter_obs.dart';

typedef ElUpdateSizeCallback = void Function(Size size);

class ElCustomMultiChildLayout extends StatefulWidget {
  /// 简单地扩展自定义多子组件布局，构建自定义布局逻辑时你可以计算父级容器尺寸，
  /// 这样可以实现在滚动容器中对 [CustomMultiChildLayout] 组件进行滚动
  const ElCustomMultiChildLayout({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    required this.delegateBuilder,
    required this.children,
  });

  /// 预定父盒子的宽度，默认无限，当处于滚动容器中，你必须预先设置它
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
  late final Obs<Size> _size = Obs(Size(widget.width, widget.height));

  /// 当第一次构建时，自定义布局会执行 [updateSize] 函数更新父元素的实际大小，
  /// 引起二次重建，此变量的作用是防止重复更新
  bool _needLayout = true;

  void updateSize(Size size) {
    ElUtil.nextTick(() {
      if (_needLayout) {
        _size.value = size;
        _needLayout = false;
      } else {
        _needLayout = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return SizedBox(
        width: _size.value.width,
        height: _size.value.height,
        child: CustomMultiChildLayout(
          delegate: widget.delegateBuilder(updateSize),
          children: widget.children,
        ),
      );
    });
  }
}
