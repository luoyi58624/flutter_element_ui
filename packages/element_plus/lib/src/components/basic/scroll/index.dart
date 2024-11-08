import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'render.dart';

class ElScroll extends StatefulWidget {
  const ElScroll({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ElScroll> createState() => _ElScrollState();
}
