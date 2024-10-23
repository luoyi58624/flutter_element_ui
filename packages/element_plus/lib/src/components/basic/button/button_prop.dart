part of 'index.dart';

/// 按钮最终 prop 配置
class _ButtonProp {
  final dynamic child;
  final double? width;
  final double height;
  final Color? bgColor;
  final Color? color;
  final String? type;
  final bool text;
  final bool bg;
  final bool link;
  final bool plain;
  final bool round;
  final bool block;
  final ElBorderBuilder borderBuilder;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final double iconSize;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool circle;
  final bool disabled;
  final bool loading;
  final Widget loadingWidget;
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;

  _ButtonProp({
    required this.child,
    required this.width,
    required this.height,
    required this.bgColor,
    required this.color,
    required this.type,
    required this.text,
    required this.bg,
    required this.link,
    required this.plain,
    required this.round,
    required this.block,
    required this.borderBuilder,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.leftIcon,
    required this.rightIcon,
    required this.circle,
    required this.disabled,
    required this.loading,
    required this.loadingWidget,
    required this.loadingBuilder,
  });

  /// 通过工厂函数创建按钮最终 prop 配置
  factory _ButtonProp.create(
    BuildContext context,
    ElButton widget,
    bool hasGroup,
  ) {
    final $data = ElButtonTheme.of(context);
    late final double $height;
    late final Color? $bgColor;
    late final String? $type;
    late final bool $text;
    late final bool $bg;
    late final bool $circle;
    late final bool $link;
    late final bool $plain;
    late final bool $round;
    late final ElBorderBuilder $borderBuilder;
    final bool $block = widget.block ?? $data.block ?? false;
    final $loading = widget.loading ?? $data.loading ?? false;
    final $disabled = (widget.disabled ?? $data.disabled ?? false) || $loading;

    if (hasGroup) {
      $height = $data.height ?? context.elConfig.size;
      $bgColor = $data.bgColor;
      $type = $data.type;
      $text = $data.text ?? false;
      $bg = $data.bg ?? false;
      $circle = false;
      $link = false;
      $plain = $data.plain ?? false;
      $round = $data.round ?? false;
      $borderBuilder = $data.borderBuilder ?? defaultBorderBuilder;
    } else {
      $height = widget.height ?? $data.height ?? context.elConfig.size;
      $bgColor = widget.bgColor ?? $data.bgColor;
      $type = widget.type ?? $data.type;
      $circle = widget.circle ?? $data.circle ?? false;
      $text = widget.text ?? $data.text ?? false;
      $bg = widget.bg ?? $data.bg ?? false;
      $link = widget.link ?? $data.link ?? false;
      $plain = widget.plain ?? $data.plain ?? false;
      $round = widget.round ?? $data.round ?? false;
      $borderBuilder =
          widget.borderBuilder ?? $data.borderBuilder ?? defaultBorderBuilder;
    }

    final $horizontalPadding = $height / 2;
    final $padding = $circle || $link
        ? null
        : (widget.padding ??
            $data.padding ??
            EdgeInsets.symmetric(horizontal: $horizontalPadding));
    final $borderRadius = $round || $circle
        ? BorderRadius.circular($height / 2)
        : widget.borderRadius ?? $data.borderRadius ?? context.elConfig.radius;

    double? $iconSize = widget.iconSize ?? $data.iconSize;
    if ($iconSize == null) {
      if ($height >= 36) {
        $iconSize = $height / 2 - 2;
      } else {
        $iconSize = $height / 2;
      }
    }

    return _ButtonProp(
      child: widget.child ?? $data.child,
      width: widget.width ?? $data.width,
      height: $height,
      bgColor: $bgColor,
      color: widget.color ?? $data.color,
      type: $type,
      text: $text,
      bg: $bg,
      link: $link,
      plain: $plain,
      round: $round,
      block: $block,
      borderBuilder: $borderBuilder,
      borderRadius: $borderRadius,
      padding: $padding,
      iconSize: $iconSize,
      leftIcon: widget.leftIcon ?? $data.leftIcon,
      rightIcon: widget.rightIcon ?? $data.rightIcon,
      circle: $circle,
      disabled: $disabled,
      loading: $loading,
      loadingWidget: widget.loadingWidget ??
          $data.loadingWidget ??
          const ElLoading(ElIcons.loading),
      loadingBuilder: widget.loadingBuilder ?? $data.loadingBuilder,
    );
  }

  static Border defaultBorderBuilder(ElButtonBorderState state) =>
      Border.all(width: 1.0, color: state.color);
}
