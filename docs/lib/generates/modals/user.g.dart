// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../modals/user.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

UserModal $userModal = UserModal();

UserModal _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $userModal;
  return UserModal(
    username: json['username']?.toString(),
    age: int.tryParse(json['age'].toString()),
  );
}

extension UserModalExtension on UserModal {
  Map<String, dynamic> _toJson() {
    return {
      'username': username,
      'age': age,
    };
  }
}
