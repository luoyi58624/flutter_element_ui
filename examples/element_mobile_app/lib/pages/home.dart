import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElPage(
      header: ElHeader(
        title: '首页',
      ),
    );
  }
}
