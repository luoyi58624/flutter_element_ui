import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';
import 'dart:async';

import '../../../themes/components/basic/text.dart';
import '../../others/triangle/triangle.dart';

part 'state.dart';

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
