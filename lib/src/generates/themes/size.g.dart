// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/size.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

SizeModel _fromJson(Map<String, dynamic> json) => SizeModel(
      width: json['width'] as double,
      maxWidth: (json['maxWidth'] ?? json['max_width']) as double,
      height: json['custom_height'] as double?,
    );

extension SizeModelExtension on SizeModel {
  Map<String, dynamic> _toJson() {
    return {
      'width': width,
      'maxWidth': maxWidth,
      'custom_height': height,
    };
  }

  SizeModel copyWith({
    double? width,
    double? maxWidth,
    double? height,
  }) {
    return SizeModel(
      width: width ?? this.width,
      maxWidth: maxWidth ?? this.maxWidth,
      height: height ?? this.height,
    );
  }

  SizeModel merge([SizeModel? other]) {
    if (other == null) return this;
    return copyWith(
      width: other.width,
      maxWidth: other.maxWidth,
      height: other.height,
    );
  }

  String _toString() {
    return 'SizeModel{width: $width,maxWidth: $maxWidth,height: $height}';
  }
}

LabelModel _fromJsonLabelModel(Map<String, dynamic> json) => LabelModel(
      label: json['label'] as String,
      value: json['value'] as String,
    );

extension LabelModelExtension on LabelModel {
  Map<String, dynamic> _toJson() {
    return {
      'label': label,
      'value': value,
    };
  }

  LabelModel copyWith({
    String? label,
    String? value,
  }) {
    return LabelModel(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }

  LabelModel merge([LabelModel? other]) {
    if (other == null) return this;
    return copyWith(
      label: other.label,
      value: other.value,
    );
  }

  String _toString() {
    return 'LabelModel{label: $label,value: $value}';
  }
}

ChatConversation _fromJsonChatConversation(Map<String, dynamic> json) =>
    ChatConversation(
      receiver_type: json['receiver_type'] as num?,
      receiver_id: json['receiver_id'] as num?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      last_message: json['last_message'] as Map<String, dynamic>?,
    );

extension ChatConversationExtension on ChatConversation {
  Map<String, dynamic> _toJson() {
    return {
      'receiver_type': receiver_type,
      'receiver_id': receiver_id,
      'name': name,
      'avatar': avatar,
      'last_message': last_message,
    };
  }

  ChatConversation copyWith({
    num? receiver_type,
    num? receiver_id,
    String? name,
    String? avatar,
    Map<String, dynamic>? last_message,
  }) {
    return ChatConversation(
      receiver_type: receiver_type ?? this.receiver_type,
      receiver_id: receiver_id ?? this.receiver_id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      last_message: last_message ?? this.last_message,
    );
  }

  ChatConversation merge([ChatConversation? other]) {
    if (other == null) return this;
    return copyWith(
      receiver_type: other.receiver_type,
      receiver_id: other.receiver_id,
      name: other.name,
      avatar: other.avatar,
      last_message: other.last_message,
    );
  }

  String _toString() {
    return 'ChatConversation{receiver_type: $receiver_type,receiver_id: $receiver_id,name: $name,avatar: $avatar,last_message: $last_message}';
  }
}
