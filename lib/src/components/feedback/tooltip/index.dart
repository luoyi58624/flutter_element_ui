import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'dart:async';

import '../../others/triangle/triangle.dart';

part 'state.dart';

part 'style.dart';

part '../../../generates/components/feedback/tooltip/index.g.dart';

class ElTooltip extends StatefulWidget {
  const ElTooltip({
    super.key,
    required this.child,
    required this.content,
    this.bgColor,
    this.selected = false,
  });

  final Widget child;
  final dynamic content;
  final Color? bgColor;

  /// 文字是否可选中
  final bool selected;

  @override
  State<ElTooltip> createState() => _ElTooltipState();
}
