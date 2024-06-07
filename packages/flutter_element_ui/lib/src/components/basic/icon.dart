import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/component.dart';
import 'package:flutter_element_ui/src/utils/util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_element_ui/src/extension.dart';

import '../../styles/basic/icon.dart';

part '../../generates/components/basic/icon.g.dart';

/// Element UI 图标
@ElComponent.all()
class ElIcon extends StatelessWidget {
  const ElIcon(
    this.child, {
    super.key,
    this.style,
    this.package = 'flutter_element_ui',
  });

  /// 渲染图标，支持以下参数：
  /// * http svg 图标
  /// * asset svg 图标，如果字符串不是http，那么将直接加载 asset 下的图标
  /// * [IconData] 字体图标
  /// * [Widget] 自定义图标
  final dynamic child;

  /// 图标样式
  final ElIconStyle? style;

  /// 当 child 为 asset 字符串地址时，你可以指定其他库的 asset 图标资产包
  final String package;

  @override
  Widget build(BuildContext context) {
    final $style = _style(context, style);
    dynamic $icon = child ?? $style.icon;
    if ($icon is String) {
      return _SvgWidget($icon, style: $style, package: package);
    } else if ($icon is IconData) {
      return Icon(
        $icon,
        size: $style.size!,
        color: $style.color,
      );
    } else if ($icon is Widget) {
      return UnconstrainedBox(
        child: SizedBox(
          width: $style.size!,
          height: $style.size!,
          child: Center(
            child: $icon,
          ),
        ),
      );
    } else {
      return Placeholder(fallbackWidth: $style.size!, fallbackHeight: $style.size!);
    }
  }
}

class _SvgWidget extends ElIcon {
  const _SvgWidget(super.child, {super.style, super.package});

  @override
  Widget build(BuildContext context) {
    double size = style!.size!;
    ColorFilter? colorFilter = style!.color == null
        ? null
        : ColorFilter.mode(
            style!.color!,
            BlendMode.srcIn,
          );
    return ElUtil.isHttp(child as String)
        ? SvgPicture.network(
            child!,
            width: size,
            height: size,
            colorFilter: colorFilter,
          )
        : SvgPicture.asset(
            child!,
            width: size,
            height: size,
            colorFilter: colorFilter,
            package: package,
          );
  }
}
