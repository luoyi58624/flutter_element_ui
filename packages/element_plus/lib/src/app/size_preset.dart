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
}

/// [ElApp] 注入的全局尺寸预设
class ElSizePreset {
  const ElSizePreset({this.button = const ElButtonSizePreset()});

  final ElButtonSizePreset button;
}

/// Element UI 组件尺寸预设抽象类
abstract class ElComponentSizePreset<S> {
  const ElComponentSizePreset();

  S get mini;

  S get small;

  S get medium;

  S get large;

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
    }
    return applyTextScaler(MediaQuery.textScalerOf(context), sizePreset);
  }
}

/// 按钮尺寸预设，你可以继承它重写预设尺寸方法，例如：
/// ```dart
/// ElSizePreset elSizePreset = ElSizePreset(
///   button: _ButtonSizePreset(),
/// );
///
/// class _ButtonSizePreset extends ElButtonSizePreset {
///   @override
///   ElButtonSizePreset get mini => const ElButtonSizePreset(
///       width: 48, height: 20, fontSize: 12, iconSize: 12);
/// }
/// ```
///
/// 然后将 elSizePreset 自定义预设传递给 [ElApp] 即可。
///
/// 注意：属性设置 ? 可选符号是为了 [ElSizePreset] 能够直接通过构造器创建对象，
/// 组件的具体尺寸由不同 size 预设提供，在返回不同 size 预设对象时你不能对任意一个属性设置为 null，
/// 否则会抛出异常。
class ElButtonSizePreset extends ElComponentSizePreset<ElButtonSizePreset> {
  final double? width;
  final double? height;
  final double? fontSize;
  final double? iconSize;
  final double? radius;

  const ElButtonSizePreset({
    this.width,
    this.height,
    this.fontSize,
    this.iconSize,
    this.radius,
  });

  @override
  ElButtonSizePreset get mini => const ElButtonSizePreset(
      width: 48, height: 28, fontSize: 12, iconSize: 12, radius: 4);

  @override
  ElButtonSizePreset get small => const ElButtonSizePreset(
      width: 56, height: 32, fontSize: 14, iconSize: 14, radius: 4);

  @override
  ElButtonSizePreset get medium => const ElButtonSizePreset(
      width: 64, height: 36, fontSize: 15, iconSize: 16, radius: 4);

  @override
  ElButtonSizePreset get large => const ElButtonSizePreset(
      width: 72, height: 40, fontSize: 16, iconSize: 18, radius: 4);

  @override
  ElButtonSizePreset applyTextScaler(textScaler, data) {
    return ElButtonSizePreset(
      width: textScaler.scale(data.width!),
      height: textScaler.scale(data.height!),
      fontSize: data.fontSize,
      iconSize: textScaler.scale(data.iconSize!),
      radius: 4,
    );
  }
}
