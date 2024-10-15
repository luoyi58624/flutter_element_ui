import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'style.dart';

part '../../../generates/components/navigation/tab/index.g.dart';

class ElTab extends StatefulWidget {
  const ElTab({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final Widget? icon;

  @override
  State<ElTab> createState() => _ElTabState();
}