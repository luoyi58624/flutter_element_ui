import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';

part 'state.dart';

part 'render.dart';

@Deprecated('')
class CustomScrollWidget extends StatefulWidget {
  const CustomScrollWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CustomScrollWidget> createState() => _ElScrollState();
}
