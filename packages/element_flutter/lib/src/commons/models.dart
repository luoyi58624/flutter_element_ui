import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';

/// 包含 [label]、[value] 简单数据模型
class LabelModel implements SerializeModel<LabelModel> {
  final String label;
  final String value;

  LabelModel(this.label, this.value);

  factory LabelModel.fromJson(Map<String, dynamic>? json) => LabelModel(
        json?['label'] ?? '',
        json?['value'] ?? '',
      );

  @override
  LabelModel fromJson(Map<String, dynamic>? json) {
    return LabelModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'label': label, 'value': value};
  }

  @override
  String toString() {
    return 'LabelModel{label: $label, value: $value}';
  }
}

/// 包含过期时间数据模型
class ExpireDataModel implements SerializeModel<ExpireDataModel> {
  /// 存储的数据
  dynamic data;

  /// 过期时间，单位毫秒，如果为 null，则表示没有过期时间，
  int? expire;

  ExpireDataModel(this.data, [int? expire]) {
    if (expire != null) {
      if (expire > 0) {
        this.expire = currentMilliseconds + expire;
      }
    }
  }

  ExpireDataModel.fromJson(Map<String, dynamic>? json) {
    data = json?['data'];
    expire = json?['expire'];
  }

  @override
  ExpireDataModel fromJson(Map<String, dynamic>? json) =>
      ExpireDataModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {'data': data, 'expire': expire};
}
