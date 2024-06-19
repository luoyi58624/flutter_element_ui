import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/styles/model.g.dart';

@ElModel.copy()
class DemoModel {
  final String user;
  late final String user2;

  String get user3 => '${user}xxx';

  DemoModel({required this.user});
}
