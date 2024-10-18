import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

class ElTag extends StatefulWidget {
  const ElTag({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final Widget? icon;

  @override
  State<ElTag> createState() => _ElTagState();
}
