class ElFontModel {
  /// 字体族名
  /// * 如果为空字符串，则表示加载系统默认字体
  /// * 如果你需要加载静态捆绑的字体，只需设置[fontFamily]即可
  final String fontFamily;

  /// 单个字体文件地址
  final String? fontUrl;

  /// 不同字重集合，key-[FontWidget.value]，value-字体文件地址
  ///
  /// 如果fontUrl、fontWidgets同时存在，则优先取fontWidgets
  final Map<int, String>? fontWeights;

  /// 从网络加载的字体模型
  const ElFontModel({
    required this.fontFamily,
    this.fontUrl,
    this.fontWeights,
  });

  factory ElFontModel.fromJson(Map<String, dynamic> json) {
    Map<int, String>? fontWeights;
    if (json["fontWeights"] != null) {
      fontWeights = json["fontWeights"].map((key, value) => MapEntry(int.parse(key), value)).cast<int, String>();
    }
    return ElFontModel(
      fontFamily: json["fontFamily"],
      fontUrl: json["fontUrl"],
      fontWeights: fontWeights,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fontFamily": fontFamily,
      "fontUrl": fontUrl,
      "fontWeights": fontWeights?.map((key, value) => MapEntry(key.toString(), value)),
    };
  }
}
