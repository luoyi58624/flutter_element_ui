part of 'index.dart';

/// 指定小部件应用的尺寸预设
class ElSize extends InheritedWidget {
  const ElSize(
    this.size, {
    super.key,
    required super.child,
  });

  final String size;

  /// 从当前上下文 context 获取最近的尺寸预设
  static String of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElSize>()?.size ?? El.medium;

  /// 接收一组 double 数据，返回符合当前 size 预设的值
  static double applyDouble<T>(BuildContext context, List<double> valueList) {
    assert(valueList.length == 5,
        'ElSize.apply valueList 参数长度必须为 5，因为尺寸预设共有 5 种尺寸');
    late double result;
    switch (ElSize.of(context)) {
      case El.mini:
        result = valueList[0];
        break;
      case El.small:
        result = valueList[1];
        break;
      case El.medium:
        result = valueList[2];
        break;
      case El.large:
        result = valueList[3];
        break;
      default:
        result = valueList[4];
        break;
    }

    final textScaler = MediaQuery.textScalerOf(context);
    if (textScaler == TextScaler.noScaling) return result;
    return textScaler.scale(result);
  }

  @override
  bool updateShouldNotify(ElSize oldWidget) => size != oldWidget.size;
}

/// 全局尺寸预设对象，你可以通过 [el] 全局服务变量访问它的实例对象
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

  /// 操作系统可能开启了全局字体缩放，在设计组件尺寸时你也应当对这一行为进行适配。
  ///
  /// 注意：文字大小不需要进行缩放，因为 [ElText]、[Text] 组件本身已经默认对 [TextScaler] 进行了适配，
  /// 要禁止操作系统的文本缩放行为，只需要在顶部嵌套 [MediaQuery] 传递固定的 [TextScaler] 对象即可。
  S applyTextScaler(TextScaler textScaler, S data);

  /// 通过当前上下文 context 获取 [ElConfig] 注入的 [ElSize] 配置，然后遍历枚举获取目标组件尺寸预设。
  S apply(BuildContext context) {
    late S sizePreset;
    switch (ElSize.of(context)) {
      case El.mini:
        sizePreset = mini;
        break;
      case El.small:
        sizePreset = small;
        break;
      case El.medium:
        sizePreset = medium;
        break;
      case El.large:
        sizePreset = large;
        break;
      case El.xLarge:
        sizePreset = xLarge;
        break;
      default:
        sizePreset = medium;
    }
    final textScaler = MediaQuery.textScalerOf(context);
    if (textScaler == TextScaler.noScaling) return sizePreset;
    return applyTextScaler(textScaler, sizePreset);
  }
}

/// 通用属性尺寸预设。
///
/// 注意：属性设置 ? 可选符号是为了 [ElSizePreset] 能够直接通过构造器创建对象，
/// 组件的具体尺寸由不同 size 预设提供，在返回不同 size 预设对象时你不能对任意一个属性设置为 null。
@ElModel.copy(generateEquals: false, generateHashCode: false)
class ElCommonSizePreset extends ElComponentSizePreset<ElCommonSizePreset> {
  /// 基础控件尺寸，例如：按钮、输入框的高度
  final double? size;

  /// 全局控件边框粗细
  final double? borderWidth;

  /// 基础控件的全局圆角值，例如：按钮、输入框
  final BorderRadius? radius;

  /// 布局类控件的全局圆角值，例如：Card、Dialog
  final BorderRadius? cardRadius;

  const ElCommonSizePreset({
    this.size,
    this.borderWidth,
    this.radius,
    this.cardRadius,
  });

  @override
  ElCommonSizePreset get mini => const ElCommonSizePreset(
        size: 28,
        borderWidth: 1.0,
        radius: BorderRadius.all(Radius.circular(3)),
        cardRadius: BorderRadius.all(Radius.circular(6)),
      );

  @override
  ElCommonSizePreset get small => const ElCommonSizePreset(
        size: 32,
        borderWidth: 1.0,
        radius: BorderRadius.all(Radius.circular(4)),
        cardRadius: BorderRadius.all(Radius.circular(8)),
      );

  @override
  ElCommonSizePreset get medium => const ElCommonSizePreset(
        size: 36,
        borderWidth: 1.0,
        radius: BorderRadius.all(Radius.circular(4)),
        cardRadius: BorderRadius.all(Radius.circular(8)),
      );

  @override
  ElCommonSizePreset get large => const ElCommonSizePreset(
        size: 40,
        borderWidth: 1.2,
        radius: BorderRadius.all(Radius.circular(5)),
        cardRadius: BorderRadius.all(Radius.circular(10)),
      );

  @override
  ElCommonSizePreset get xLarge => const ElCommonSizePreset(
        size: 46,
        borderWidth: 1.5,
        radius: BorderRadius.all(Radius.circular(6)),
        cardRadius: BorderRadius.all(Radius.circular(12)),
      );

  @override
  ElCommonSizePreset applyTextScaler(textScaler, data) {
    return ElCommonSizePreset(
      size: textScaler.scale(data.size!),
      borderWidth: textScaler.scale(data.borderWidth!),
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
  final double? minWidth;
  final double? fontSize;
  final double? iconSize;

  const ElButtonSizePreset({
    this.minWidth,
    this.fontSize,
    this.iconSize,
  });

  @override
  ElButtonSizePreset get mini =>
      const ElButtonSizePreset(minWidth: 48, fontSize: 12, iconSize: 13);

  @override
  ElButtonSizePreset get small =>
      const ElButtonSizePreset(minWidth: 56, fontSize: 14, iconSize: 15);

  @override
  ElButtonSizePreset get medium =>
      const ElButtonSizePreset(minWidth: 64, fontSize: 15, iconSize: 16);

  @override
  ElButtonSizePreset get large =>
      const ElButtonSizePreset(minWidth: 72, fontSize: 16, iconSize: 18);

  @override
  ElButtonSizePreset get xLarge =>
      const ElButtonSizePreset(minWidth: 80, fontSize: 18, iconSize: 20);

  @override
  ElButtonSizePreset applyTextScaler(textScaler, data) {
    return ElButtonSizePreset(
      minWidth: textScaler.scale(data.minWidth!),
      fontSize: data.fontSize,
    );
  }
}
