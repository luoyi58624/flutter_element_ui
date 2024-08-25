import 'package:docs/global.dart';
import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget mergeTextStyle(TextStyle style) => DefaultTextStyle.merge(
        style: style,
        child: this,
      );

  /// 根据全局状态动态构建选中支持
  Widget get buildSelectionArea {
    return ObsBuilder(builder: (context) {
      if (GlobalState.enableGlobalTextSelected.value) {
        return SelectionArea(child: this);
      } else {
        return this;
      }
    });
  }
}
