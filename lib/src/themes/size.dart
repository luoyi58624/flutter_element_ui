import '../global.dart';

part '../generates/themes/size.g.dart';

@ElModel.copy()
class SizeModel implements ElSerializeModel {
  final double width;
  final double height;

  SizeModel({
    required this.width,
    required this.height,
  });

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        width: json['name'],
        height: json['age'],
      );

  @override
  ElSerializeModel fromJson(Map<String, dynamic> json) {
    return SizeModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height};
  }

  @override
  String toString() {
    return 'SizeModel{width: $width, height: $height}';
  }
}
