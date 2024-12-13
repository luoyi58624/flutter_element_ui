part of 'index.dart';

/// [ElSize] 序列化
class ElSizeSerialize implements ElSerialize<ElSize> {
  const ElSizeSerialize();

  @override
  String? serialize(ElSize? obj) => obj!.index.toString();

  @override
  ElSize? deserialize(String? str) {
    if (str == null) return null;
    switch (int.parse(str)) {
      case 0:
        return ElSize.mini;
      case 1:
        return ElSize.small;
      case 2:
        return ElSize.medium;
      case 3:
        return ElSize.large;
      case 4:
        return ElSize.xLarge;
    }
    return null;
  }
}

/// Element UI 所有组件预设尺寸枚举类
enum ElSize {
  /// 极小尺寸
  mini,

  /// 小尺寸
  small,

  /// 中等尺寸（默认）
  medium,

  /// 大尺寸
  large,

  /// 超大尺寸
  xLarge,
}

/// [ElApp] 注入的全局尺寸预设
class ElSizePreset {
  const ElSizePreset({
    this.common = const ElCommonSizePreset(),
    this.button = const ElButtonSizePreset(),
  });

  final ElCommonSizePreset common;
  final ElButtonSizePreset button;
}

/// Element UI 组件尺寸预设抽象类
abstract class ElComponentSizePreset<S> {
  const ElComponentSizePreset();

  S get mini;

  S get small;

  S get medium;

  S get large;

  S get xLarge;

  /// 操作系统可能开启了全局字体缩放，在设计组件尺寸时你也需要对这一行为进行适配。
  ///
  /// 注意：文字大小不需要进行缩放，因为 [ElText]、[Text] 组件本身已经默认对 [TextScaler] 进行了适配。
  S applyTextScaler(TextScaler textScaler, S data);

  /// 通过当前上下文 context 获取 [ElConfig] 注入的 [ElSize] 配置，然后遍历枚举获取目标组件尺寸预设。
  S apply(BuildContext context) {
    late S sizePreset;
    switch (context.elConfig.elSize!) {
      case ElSize.mini:
        sizePreset = mini;
        break;
      case ElSize.small:
        sizePreset = small;
        break;
      case ElSize.medium:
        sizePreset = medium;
        break;
      case ElSize.large:
        sizePreset = large;
        break;
      case ElSize.xLarge:
        sizePreset = xLarge;
        break;
    }
    final textScaler = MediaQuery.textScalerOf(context);
    if (textScaler == TextScaler.noScaling) return sizePreset;
    return applyTextScaler(textScaler, sizePreset);
  }
}

/// 通用属性尺寸预设，你可以继承它重写预设尺寸方法，例如：
/// ```dart
/// ElSizePreset elSizePreset = ElSizePreset(
///   common: _CommonSizePreset(),
/// );
///
/// class _CommonSizePreset extends ElCommonSizePreset {
///   @override
///   ElCommonSizePreset get mini => const ElCommonSizePreset();
/// }
/// ```
///
/// 然后将 elSizePreset 自定义预设传递给 [ElApp] 即可。
///
/// 注意：属性设置 ? 可选符号是为了 [ElSizePreset] 能够直接通过构造器创建对象，
/// 组件的具体尺寸由不同 size 预设提供，在返回不同 size 预设对象时你不能对任意一个属性设置为 null。
class ElCommonSizePreset extends ElComponentSizePreset<ElCommonSizePreset> {
  /// 全局默认的文本大小
  final double? fontSize;

  /// 全局默认的图标大小
  final double? iconSize;

  /// 基础控件的全局圆角值，例如：Button、Input
  final BorderRadius? radius;

  /// 布局类控件的全局圆角值，例如：Card、Dialog
  final BorderRadius? cardRadius;

  const ElCommonSizePreset({
    this.fontSize,
    this.iconSize,
    this.radius,
    this.cardRadius,
  });

  @override
  ElCommonSizePreset get mini => const ElCommonSizePreset(
        fontSize: 12,
        iconSize: 14,
        radius: BorderRadius.all(Radius.circular(3)),
        cardRadius: BorderRadius.all(Radius.circular(5)),
      );

  @override
  ElCommonSizePreset get small => const ElCommonSizePreset(
        fontSize: 14,
        iconSize: 16,
        radius: BorderRadius.all(Radius.circular(4)),
        cardRadius: BorderRadius.all(Radius.circular(6)),
      );

  @override
  ElCommonSizePreset get medium => const ElCommonSizePreset(
        fontSize: 15,
        iconSize: 18,
        radius: BorderRadius.all(Radius.circular(4)),
        cardRadius: BorderRadius.all(Radius.circular(6)),
      );

  @override
  ElCommonSizePreset get large => const ElCommonSizePreset(
        fontSize: 16,
        iconSize: 20,
        radius: BorderRadius.all(Radius.circular(4)),
        cardRadius: BorderRadius.all(Radius.circular(6)),
      );

  @override
  ElCommonSizePreset get xLarge => const ElCommonSizePreset(
        fontSize: 18,
        iconSize: 24,
        radius: BorderRadius.all(Radius.circular(6)),
        cardRadius: BorderRadius.all(Radius.circular(8)),
      );

  @override
  ElCommonSizePreset applyTextScaler(textScaler, data) {
    return ElCommonSizePreset(
      fontSize: data.fontSize,
      iconSize: textScaler.scale(data.iconSize!),
      radius: BorderRadius.only(
        topLeft: Radius.elliptical(
          textScaler.scale(data.radius!.topLeft.x),
          textScaler.scale(data.radius!.topLeft.y),
        ),
        topRight: Radius.elliptical(
          textScaler.scale(data.radius!.topRight.x),
          textScaler.scale(data.radius!.topRight.y),
        ),
        bottomLeft: Radius.elliptical(
          textScaler.scale(data.radius!.bottomLeft.x),
          textScaler.scale(data.radius!.bottomLeft.y),
        ),
        bottomRight: Radius.elliptical(
          textScaler.scale(data.radius!.bottomRight.x),
          textScaler.scale(data.radius!.bottomRight.y),
        ),
      ),
      cardRadius: BorderRadius.only(
        topLeft: Radius.elliptical(
          textScaler.scale(data.cardRadius!.topLeft.x),
          textScaler.scale(data.cardRadius!.topLeft.y),
        ),
        topRight: Radius.elliptical(
          textScaler.scale(data.cardRadius!.topRight.x),
          textScaler.scale(data.cardRadius!.topRight.y),
        ),
        bottomLeft: Radius.elliptical(
          textScaler.scale(data.cardRadius!.bottomLeft.x),
          textScaler.scale(data.cardRadius!.bottomLeft.y),
        ),
        bottomRight: Radius.elliptical(
          textScaler.scale(data.cardRadius!.bottomRight.x),
          textScaler.scale(data.cardRadius!.bottomRight.y),
        ),
      ),
    );
  }
}

/// 按钮尺寸预设
class ElButtonSizePreset extends ElComponentSizePreset<ElButtonSizePreset> {
  final double? width;
  final double? height;

  const ElButtonSizePreset({
    this.width,
    this.height,
  });

  @override
  ElButtonSizePreset get mini =>
      const ElButtonSizePreset(width: 48, height: 24);

  @override
  ElButtonSizePreset get small =>
      const ElButtonSizePreset(width: 56, height: 32);

  @override
  ElButtonSizePreset get medium =>
      const ElButtonSizePreset(width: 64, height: 36);

  @override
  ElButtonSizePreset get large =>
      const ElButtonSizePreset(width: 72, height: 40);

  @override
  ElButtonSizePreset get xLarge =>
      const ElButtonSizePreset(width: 80, height: 46);

  @override
  ElButtonSizePreset applyTextScaler(textScaler, data) {
    return ElButtonSizePreset(
      width: textScaler.scale(data.width!),
      height: textScaler.scale(data.height!),
    );
  }
}
