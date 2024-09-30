// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../modals/user.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

UserModal _fromJson(Map<String, dynamic> json) => UserModal(
      username: json['username']?.toString(),
      age: int.tryParse(json['age'].toString()),
    );

extension UserModalExtension on UserModal {
  /// 将实体对象转成 json
  Map<String, dynamic> _toJson() {
    return {
      'username': username,
      'age': age,
    };
  }
}
