part of flutter_element_ui;

/// 默认的图标样式
class ElDefaultIconStyle extends InheritedWidget {
  const ElDefaultIconStyle({
    super.key,
    required super.child,
    this.icon,
    this.svgUrl,
    this.size,
    this.color,
  }) : assert(
            (icon == null && svgUrl == null) ||
                (icon != null && svgUrl == null && svgUrl != '') ||
                (icon == null && svgUrl != null && svgUrl != ''),
            'icon和svgUrl不能同时存在');

  /// 默认的icon
  final IconData? icon;

  /// 默认的svg图标地址
  final String? svgUrl;
  final double? size;
  final Color? color;

  static ElDefaultIconStyle? of(BuildContext context) {
    final ElDefaultIconStyle? result = context.dependOnInheritedWidgetOfExactType<ElDefaultIconStyle>();
    return result;
  }

  @override
  bool updateShouldNotify(ElDefaultIconStyle oldWidget) {
    return true;
  }
}

/// Element UI 图标，它只是在[Icon]的基础上添加了[ElDefaultIconStyle]默认图标样式，同时扩展了svg图标，底层基于[flutter_svg]
class ElIcon extends StatelessWidget {
  /// 渲染普通的icon
  const ElIcon(
    this.icon, {
    super.key,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
    this.applyTextScaling,
  })  : svgUrl = null,
        assert(fill == null || (0.0 <= fill && fill <= 1.0)),
        assert(weight == null || (0.0 < weight)),
        assert(opticalSize == null || (0.0 < opticalSize));

  /// 渲染svg图标
  const ElIcon.svg(
    this.svgUrl, {
    super.key,
    this.size,
    this.color,
  })  : icon = null,
        fill = null,
        weight = null,
        grade = null,
        opticalSize = null,
        shadows = null,
        semanticLabel = null,
        textDirection = null,
        applyTextScaling = null;

  /// 渲染普通图标
  final IconData? icon;

  /// 渲染svg图标
  final String? svgUrl;

  final double? size;
  final Color? color;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final bool? applyTextScaling;

  @override
  Widget build(BuildContext context) {
    ElDefaultIconStyle? style = ElDefaultIconStyle.of(context);
    if (svgUrl != null || (style?.svgUrl != null && style!.svgUrl != '')) {
      return _SvgWidget(
        svgUrl,
        size: size ?? style?.size ?? ElAppData.of(context).config.iconSize,
        color: color ?? style?.color,
        package: 'flutter_element_ui',
      );
    } else {
      return Icon(
        icon ?? style?.icon,
        size: size ?? style?.size ?? ElAppData.of(context).config.iconSize,
        color: color ?? style?.color,
        fill: fill,
        weight: weight,
        grade: grade,
        opticalSize: opticalSize,
        shadows: shadows,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
        applyTextScaling: applyTextScaling,
      );
    }
  }
}

class _SvgWidget extends StatelessWidget {
  const _SvgWidget(
    this.url, {
    this.size,
    this.color,
    this.package,
  });

  /// svg地址路径，它根据地址前缀自动加载不同环境的svg：
  /// * http、https - 加载网络上的svg
  /// * asset、assets、/asset、/assets - 加载项目资产中的svg
  final String? url;

  final double? size;

  final Color? color;

  /// 指定其他库的asset资产包
  final String? package;

  @override
  Widget build(BuildContext context) {
    assert(url != null);
    if (url!.startsWith('http')) {
      return SvgPicture.network(
        url!,
        width: size,
        height: size,
        color: color,
      );
    } else if (url!.startsWith('asset') || url!.startsWith('/asset')) {
      return SvgPicture.asset(
        url!,
        width: size,
        height: size,
        color: color,
        package: package,
      );
    }
    return const SizedBox();
  }
}
