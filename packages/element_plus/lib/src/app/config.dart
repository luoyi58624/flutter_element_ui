part of 'index.dart';

@ElModel.copy()
class ElConfigData {
  static const ElConfigData globalData = ElConfigData(
    size: 36,
    borderWidth: 1.0,
  );

  /// Element UI 通用配置
  const ElConfigData({
    this.size,
    this.borderWidth,
  });

  /// 基础控件尺寸，例如：按钮、输入框
  final double? size;

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
