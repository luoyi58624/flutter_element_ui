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

  factory SizeModel.fromJson(Map<String, dynamic> json) =>
      _fromJsonSizeModel(json);

  @override
  ElSerializeModel fromJson(Map<String, dynamic> json) =>
      _fromJsonSizeModel(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}

@ElModel.all()
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
