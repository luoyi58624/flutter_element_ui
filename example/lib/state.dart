import 'package:flutter/widgets.dart';

class GlobalState {
  static final ValueNotifier<int> counter = ValueNotifier<int>(0);
  static final ValueNotifier<ElMenuStateModel> elMenu = ValueNotifier<ElMenuStateModel>(ElMenuStateModel());
}

class ElMenuStateModel {
  String activePath;
  bool isCollapse;

  ElMenuStateModel({
    this.activePath = '/',
    this.isCollapse = false,
  });

  ElMenuStateModel copyWith({
    String? activePath,
    bool? isCollapse,
  }) {
    return ElMenuStateModel(
      activePath: activePath ?? this.activePath,
      isCollapse: isCollapse ?? this.isCollapse,
    );
  }
}
