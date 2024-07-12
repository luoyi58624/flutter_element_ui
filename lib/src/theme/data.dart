part of '../theme.dart';

/// Element UI 全局主题数据
class ElThemeData {
  /// 亮色主题
  late final ElBrightnessData theme;

  /// 暗色主题
  late final ElBrightnessData darkTheme;

  /// 组件配置
  late final ElConfigData config;

  /// 响应式断点配置
  final ElResponsiveData responsive;

  /// 文本排版配置
  late final ElTypographyData typography;

  ElThemeData({
    ElBrightnessData? theme,
    ElBrightnessData? darkTheme,
    ElConfigData? config,
    this.responsive = const ElResponsiveData(),
    ElTypographyData? typography,
  }) {
    this.theme = theme ?? ElBrightnessData.lightTheme;
    this.darkTheme = darkTheme ?? ElBrightnessData.darkTheme;
    this.config = config ?? ElConfigData.data;
    this.typography = typography ?? ElTypographyData.data;
  }
}
