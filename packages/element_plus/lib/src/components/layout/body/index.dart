import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Element UI 主窗口
class ElBody extends StatefulWidget {
  const ElBody({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<ElBody> createState() => _ElBodyState();
}

class _ElBodyState extends State<ElBody> {
  @override
  Widget build(BuildContext context) {
    late BuildContext $context;
    late FocusScopeNode focusScopeNode;
    return ElEvent(
      behavior: HitTestBehavior.opaque,
      canRequestFocus: false,
      onTap: () {
        if (focusScopeNode.hasFocus == false) {
          ElFocusScope.requestFocus($context);
        }
      },
      child: ElFocusScope(
        child: Builder(builder: (context) {
          $context = context;
          focusScopeNode = FocusScope.of(context);
          return widget.child ?? const SizedBox();
        }),
      ),
    );
  }
}
