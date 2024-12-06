part of 'index.dart';

@ElModel.copy()
class ElConfigData {
  /// 默认的全局配置数据，属性添加可选符号是为了方便合并祖先默认配置的全局样式，
  /// ElApp 会将 [globalData] 作为默认值进行注入，所以在使用过程中它们不会为 null，
  /// 你可以放心地添加 ! 符号移除警告。
  static const ElConfigData globalData = ElConfigData(
    size: 36,
    radius: BorderRadius.all(Radius.circular(4)),
    cardRadius: BorderRadius.all(Radius.circular(6)),
    borderWidth: 1.0,
  );

  /// Element UI 通用配置
  const ElConfigData({
    this.size,
    this.radius,
    this.cardRadius,
    this.borderWidth,
  });

  /// 基础控件尺寸，例如：按钮、输入框
  final double? size;

  /// 基础控件默认圆角值，例如：按钮、输入框
  final BorderRadius? radius;

  /// 尺寸比较大的布局类组件圆角值，例如：卡片
  final BorderRadius? cardRadius;

  /// 基础控件默认边框尺寸
  final double? borderWidth;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

class ElConfig extends StatelessWidget {
  /// 局部配置构造函数
  const ElConfig({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElConfigData data;

  static ElConfigData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElConfig>()?.data ??
      ElApp.of(context).config;

  @override
  Widget build(BuildContext context) {
    return _ElConfig(
      data: context.elConfig.merge(data),
      child: child,
    );
  }
}

class _ElConfig extends InheritedWidget {
  const _ElConfig({
    required super.child,
    required this.data,
  });

  final ElConfigData data;

  @override
  bool updateShouldNotify(_ElConfig oldWidget) => true;
}
