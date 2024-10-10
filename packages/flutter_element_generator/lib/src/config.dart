/// 当启动代码生成器时将初始化全局构建配置
late BuilderConfig builderConfig;

/// 构建器配置
class BuilderConfig {
  /// 生成的默认模型对象命名模版，默认以 $ 作为前缀，对应的格式为 ${{}}
  /// * UserModel -> $userModel
  /// * PersonModel -> $personModel
  ///
  /// {{}} 占位符表示首字母小写的类名，请最好设置容易区分的命名方式，因为这些默认的模型对象属于全局实例，
  /// 模型对象若实现了 [ElSerializeModel] 序列化模型接口，那么当对象嵌套对象时会直接调用目标全局实例对象的 fromJson 方法。
  final String modelNameTemplate;

  BuilderConfig({required this.modelNameTemplate});

  factory BuilderConfig.fromConfig(Map<String, dynamic> config) {
    return BuilderConfig(
      modelNameTemplate: config['model_name_template'] ?? '\${{}}',
    );
  }
}
