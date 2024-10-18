/// 当启动代码生成器时将初始化全局构建配置
late ModelBuilderConfig modelBuilderConfig;

/// 构建器配置
class ModelBuilderConfig {
  /// 生成的默认模型对象命名模版，默认以 $ 作为前缀，对应的格式为 ${{}}
  /// * UserModel -> $userModel
  /// * PersonModel -> $personModel
  ///
  /// {{}} 占位符表示首字母小写的类名，请最好设置容易区分的命名方式，因为这些默认的模型对象属于全局实例，
  /// 模型对象若实现了 [ElSerializeModel] 序列化模型接口，那么当对象嵌套对象时会直接调用目标全局实例对象的 fromJson 方法。
  final String modelNameTemplate;

  ModelBuilderConfig({required this.modelNameTemplate});

  factory ModelBuilderConfig.fromConfig(Map<String, dynamic> config) {
    return ModelBuilderConfig(
      modelNameTemplate: config['model_name_template'] ?? '\${{}}',
    );
  }
}

/// 当启动代码生成器时将初始化全局构建配置
late ThemeModelBuilderConfig themeModelBuilderConfig;

/// 构建器配置
class ThemeModelBuilderConfig {
  /// 全局主题类名
  final String globalThemeClassName;

  ThemeModelBuilderConfig({required this.globalThemeClassName});

  factory ThemeModelBuilderConfig.fromConfig(Map<String, dynamic> config) {
    return ThemeModelBuilderConfig(
      globalThemeClassName: config['global_theme_class_name'] ?? 'ElThemeData2',
    );
  }
}
