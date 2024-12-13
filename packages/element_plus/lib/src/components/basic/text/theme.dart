part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '文本默认样式', generateThemeWidget: false)
class ElTextThemeData {
  static const theme = ElTextThemeData(
    textStyle: TextStyle(
      color: Color(0xff323232),
    ),
    regularStyle: TextStyle(
      color: Color(0xff606266),
    ),
    secondaryStyle: TextStyle(
      color: Color(0xff909399),
    ),
    placeholderStyle: TextStyle(
      color: Color(0xffA8ABB2),
    ),
  );
  static const darkTheme = ElTextThemeData(
    textStyle: TextStyle(
      color: Color(0xfff2f2f2),
    ),
    regularStyle: TextStyle(
      color: Color(0xffCFD3DC),
    ),
    secondaryStyle: TextStyle(
      color: Color(0xffA3A6AD),
    ),
    placeholderStyle: TextStyle(
      color: Color(0xff8D9095),
    ),
  );

  const ElTextThemeData({
    required this.textStyle,
    required this.regularStyle,
    required this.secondaryStyle,
    required this.placeholderStyle,
  });

  /// 默认文本样式，构建 [ElApp] 时，会将此样式作为 [ElDefaultTextStyle] 小部件的默认文本样式
  final TextStyle textStyle;

  /// 常规文本样式
  final TextStyle regularStyle;

  /// 次要文本样式
  final TextStyle secondaryStyle;

  /// 占位文本样式
  final TextStyle placeholderStyle;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
