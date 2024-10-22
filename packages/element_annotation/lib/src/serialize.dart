/// 对象序列化接口，此接口用于实现自定义序列化注解
abstract interface class ElSerialize<T> {
  /// 序列化: object -> string
  String? serialize(T? data);

  /// 反序列化: string -> object
  T? deserialize(String? str);
}

/// 数据模型序列化接口，此接口用于 Model 数据类
abstract interface class ElSerializeModel<T> {
  /// 将 json 转成模型对象
  T fromJson(Map<String, dynamic>? json);

  /// 将模型对象转成 json
  Map<String, dynamic> toJson();
}
