// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/user.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

UserModel $userModel = UserModel();

UserModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $userModel;
  return UserModel(
    username: json['username']?.toString(),
    age: int.tryParse(json['age'].toString()),
  );
}

extension UserModelExtension on UserModel {
  Map<String, dynamic> _toJson() {
    return {
      'username': username,
      'age': age,
    };
  }

  UserModel copyWith({
    String? username,
    int? age,
  }) {
    return UserModel(
      username: username ?? this.username,
      age: age ?? this.age,
    );
  }

  UserModel merge([UserModel? other]) {
    if (other == null) return this;
    return copyWith(
      username: other.username,
      age: other.age,
    );
  }

  String _toString() {
    return 'UserModel{username: $username,age: $age}';
  }
}