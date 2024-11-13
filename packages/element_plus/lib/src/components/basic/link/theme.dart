part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '超链接默认样式')
class ElLinkThemeData {
  static const theme = ElLinkThemeData(
    color: Color.fromRGBO(9, 105, 218, 1.0),
    activeColor: Color.fromRGBO(9, 105, 218, 1.0),
  );
  static const darkTheme = ElLinkThemeData(
    color: Color.fromRGBO(64, 158, 255, 1.0),
    activeColor: Color.fromRGBO(64, 158, 255, 1.0),
  );

  const ElLinkThemeData({
    required this.color,
    required this.activeColor,
    this.decoration = ElLinkDecoration.none,
    this.allowDrag = true,
  });

  /// 默认的超链接文本颜色
  final Color color;

  /// 激活的超链接文本颜色
  final Color activeColor;

  /// 超链接下划线显示逻辑
  final ElLinkDecoration decoration;

  /// 是否允许拖拽超链接（仅限 web 平台）
  final bool allowDrag;
}
