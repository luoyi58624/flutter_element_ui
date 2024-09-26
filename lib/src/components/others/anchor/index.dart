import 'package:flutter/widgets.dart';

import '../../../global.dart';

part 'state.dart';
part 'service.dart';

class ElAnchor extends StatefulWidget {
  /// Element UI 锚点小部件，你可以通过 [el.anchor] 访问相关 api
  const ElAnchor({
    super.key,
    required this.name,
    required this.child,
  });

  /// 锚点名字，请确保它唯一
  final String name;
  final Widget child;

  @override
  State<ElAnchor> createState() => _ElAnchorState();
}

