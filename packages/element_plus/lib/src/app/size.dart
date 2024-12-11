part of 'index.dart';

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

class ElSizePreset {
  const ElSizePreset({this.button = const ElButtonSizePreset()});

  final ElButtonSizePreset button;
}

abstract class _SizePreset<S> {
  const _SizePreset();

  S get mini;

  S get small;

  S get medium;

  S get large;

  /// 通过当前上下文 context 应用得到预设的尺寸
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
    return sizePreset;
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
/// 提示：属性设置 ? 可选符号是为了能够直接通过构造器创建对象，实际不为 null。
class ElButtonSizePreset extends _SizePreset<ElButtonSizePreset> {
  final double? width;
  final double? height;
  final double? fontSize;
  final double? iconSize;

  const ElButtonSizePreset({
    this.width,
    this.height,
    this.fontSize,
    this.iconSize,
  });

  @override
  ElButtonSizePreset get mini => const ElButtonSizePreset(
      width: 48, height: 24, fontSize: 12, iconSize: 12);

  @override
  ElButtonSizePreset get small => const ElButtonSizePreset(
      width: 56, height: 30, fontSize: 14, iconSize: 14);

  @override
  ElButtonSizePreset get medium => const ElButtonSizePreset(
      width: 64, height: 36, fontSize: 15, iconSize: 16);

  @override
  ElButtonSizePreset get large => const ElButtonSizePreset(
      width: 72, height: 40, fontSize: 16, iconSize: 18);
}
