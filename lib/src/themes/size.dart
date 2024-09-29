import '../global.dart';

part '../generates/themes/size.g.dart';

@ElModel.all()
class SizeModel implements ElSerializeModel {
  final double width;
  final double? height;

  SizeModel({
    required this.width,
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
