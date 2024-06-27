import 'package:flutter/material.dart';

import 'global.dart';

class GlobalState {
  static final brightness = Obs<Brightness?>(null);
  static final counter = Obs(0);
  static final elMenu = Obs<ElMenuStateModel>(ElMenuStateModel());
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
