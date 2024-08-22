import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstallPage extends HookWidget {
  const InstallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      children: [
        H1('安装'),
      ],
    );
  }
}
