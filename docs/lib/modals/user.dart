import 'package:docs/global.dart';

part '../generates/modals/user.g.dart';

@ElModel.json()
class UserModal implements ElSerialize {
  final String? username;
  final int? age;

  UserModal({
    this.username,
    this.age,
  });

  @override
  ElSerialize fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();
}
