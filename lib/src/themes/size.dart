import '../global.dart';

part '../generates/themes/size.g.dart';

@ElModel.all()
class SizeModel implements ElSerializeModel {
  final double width;
  final double maxWidth;
  final double? height;

  SizeModel({
    required this.width,
    required this.maxWidth,
    required this.height,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  ElSerializeModel fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}

@ElModel.all(fromJsonDiff: true)
class LabelModel {
  final String label;
  final String value;

  LabelModel({
    required this.label,
    required this.value,
  });

  factory LabelModel.fromJson(Map<String, dynamic> json) =>
      _fromJsonLabelModel(json);

  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}

@ElModel.all(fromJsonDiff: true)
class ChatConversation {
  // 会话类型：1-单聊  2-群聊
  final num? receiver_type;

  // 会话ID
  final num? receiver_id;
  final String? name;
  final String? avatar;
  final Map<String, dynamic>? last_message;

  ChatConversation({
    required this.receiver_type,
    required this.receiver_id,
    required this.name,
    required this.avatar,
    required this.last_message,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) =>
      _fromJsonChatConversation(json);

  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}
