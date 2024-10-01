/// Model 数据类序列化模型接口，对于实现此接口的 class，代码生成器会自动识别它们并应用它们的序列化函数
abstract interface class ElSerializeModel<T> {
  /// 将 json 转成模型对象
  T fromJson(Map<String, dynamic>? json);

  /// 将模型对象转成 json
  Map<String, dynamic> toJson();
}
