import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/navigation/tabs.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '标签容器默认样式')
class ElTabsThemeData {
  static const theme = ElTabsThemeData(
    bgColor: Color.fromRGBO(227, 227, 227, 1.0),
    thumbColor: Color(0x59000000),
  );
  static const darkTheme = ElTabsThemeData(
    bgColor: Color.fromRGBO(60, 63, 65, 1.0),
    thumbColor: Color(0x80FFFFFF),
  );

  const ElTabsThemeData({
    this.builder,
    this.size,
    this.direction,
    this.bgColor,
    this.thumbColor,
    this.padding,
    this.itemGap,
    this.enabledDrag,
    this.dragDelay,
    this.autoScrollerVelocityScalar,
    this.dragProxyDecorator,
  });

  /// 构建标签容器外观
  final ElWidgetWrapperBuilder? builder;

  /// 标签容器尺寸，默认 50
  final double? size;

  /// 标签方向
  final AxisDirection? direction;

  /// 标签容器背景颜色
  final Color? bgColor;

  /// 标签容器滚动条颜色
  final Color? thumbColor;

  /// 标签容器内边距，默认 0
  final EdgeInsets? padding;

  /// 子标签之间的间距，默认 0
  final double? itemGap;

  /// 开启拖拽排序，默认 false
  final bool? enabledDrag;

  /// 触发拖拽延迟时间，默认 200 毫秒
  final Duration? dragDelay;

  /// 拖拽到临界点时自动滚动速率，默认 100
  final double? autoScrollerVelocityScalar;

  /// 自定义拖拽代理
  final ReorderItemProxyDecorator? dragProxyDecorator;
}
