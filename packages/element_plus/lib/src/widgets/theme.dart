import 'package:flutter/widgets.dart';

abstract class ElLocalTheme extends StatelessWidget {
  const ElLocalTheme({super.key}) : isDefaultTheme = false;

  const ElLocalTheme.$default({super.key}) : isDefaultTheme = true;

  @protected
  final bool isDefaultTheme;
}
