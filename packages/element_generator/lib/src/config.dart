/// 当启动代码生成器时将初始化全局构建配置
late ModelBuilderConfig modelBuilderConfig;

/// 构建器配置
class ModelBuilderConfig {
  /// 生成的默认模型对象命名模版，默认以 $$ 作为前缀：
  /// * UserModel -> $$userModel
  /// * PersonModel -> $$personModel
  ///
  /// {{}} 占位符表示首字母小写的类名，使用 $$ 作为前缀一般表示这种变量需要公开、但不推荐用户引用它，
  /// 如果你不希望用户访问它们，想将前缀改为 _ 私有符号，这样做是允许的，但你需要注意一个问题：
  /// 确保相互引用的实体类在同一文件内，否则生成的部分代码会无法访问目标变量，例如：formJson。
  final String modelNameTemplate;

  ModelBuilderConfig({required this.modelNameTemplate});

  factory ModelBuilderConfig.fromConfig(Map<String, dynamic> config) {
    return ModelBuilderConfig(
      modelNameTemplate: config['model_name_template'] ?? '\$\${{}}',
    );
  }
}
