import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/utils/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_element_ui/src/extension.dart';

import '../../../styles/basic/icon.dart';

part 'icons.dart';

/// Element UI 图标
class ElIcon extends StatelessWidget {
  const ElIcon(
    this.child, {
    super.key,
    this.style,
    this.package = 'flutter_element_ui',
  });

  /// 渲染图标，支持以下参数：
  /// * http svg 图标
  /// * asset svg 图标
  /// * [IconData] 字体图标
  /// * [Widget] 自定义图标，你可以通过[of]获取当前图标样式
  final dynamic child;

  /// 图标样式
  final ElIconStyle? style;

  /// 当 child 为 asset 字符串地址时，指定其他库的 asset 图标资产包
  final String package;

  @override
  Widget build(BuildContext context) {
    final $style = ElIconImportantTheme._merge(
      context,
      context.elConfig.iconStyle.merge(
        ElIconTheme._merge(context, style),
      ),
    );
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

class ElIconTheme extends InheritedWidget {
  /// 局部默认样式小部件
  const ElIconTheme({super.key, required super.child, required this.style});

  final ElIconStyle style;

  static ElIconStyle? _merge(BuildContext context, ElIconStyle? style) {
    var defaultStyle = context.dependOnInheritedWidgetOfExactType<ElIconTheme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(ElIconTheme oldWidget) => oldWidget.style != style;
}

class ElIconImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
  const ElIconImportantTheme({super.key, required super.child, required this.style});

  final ElIconStyle style;

  static ElIconStyle _merge(BuildContext context, ElIconStyle style) =>
      style.merge(context.dependOnInheritedWidgetOfExactType<ElIconImportantTheme>()?.style);

  @override
  bool updateShouldNotify(ElIconImportantTheme oldWidget) => oldWidget.style != style;
}
