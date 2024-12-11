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

mixin ElSizeMixin<T extends StatefulWidget, S> on State<T> {
  /// 返回极小尺寸属性配置
  @protected
  S mini(BuildContext context);

  /// 返回小尺寸属性配置
  S small(BuildContext context);

  /// 返回中等尺寸属性配置
  S medium(BuildContext context);

  /// 返回大尺寸属性配置
  S large(BuildContext context);

  /// 通过当前上下文访问 [ElConfig] 配置的 size 属性，返回组件自定义的预设尺寸配置
  S getSizePreset() {
    late S sizePreset;
    switch (context.elConfig.elSize!) {
      case ElSize.mini:
        sizePreset = mini(context);
        break;
      case ElSize.small:
        sizePreset = small(context);
        break;
      case ElSize.medium:
        sizePreset = medium(context);
        break;
      case ElSize.large:
        sizePreset = large(context);
        break;
    }
    return sizePreset;
  }
}
