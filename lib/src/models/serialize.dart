/// 序列化模型接口
abstract interface class ElSerializeModel {
  /// 将 json 转成模型对象
  ElSerializeModel fromJson(Map<String, dynamic> json);

  /// 将模型对象转成 json
  Map<String, dynamic> toJson();
}

