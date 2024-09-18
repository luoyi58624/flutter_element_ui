export './web.dart' if (dart.library.io) './io.dart' show ElLink;

enum ElLinkDecoration {
  /// 不显示下划线
  none,

  /// 总是显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

enum ElLinkTarget {
  /// 在当前页面打开
  self,

  /// 在新标签页打开 (默认)
  blank,
}
