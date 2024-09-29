import 'dart:convert';

import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    String json = '{"width": 120.0, "max_width": 600.0, "height": 400.0}';
    final model = SizeModel(
      width: 200,
      maxWidth: 300,
      height: 100
    );
    el.i(model.toJson());
    final model2 = SizeModel.fromJson(jsonDecode(json));
    return [
      ElText(model),
      ElText(model2),
    ];
  }
}
