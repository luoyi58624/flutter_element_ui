import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

Widget buildTitle(String title) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    const Gap(28),
    H4(title),
    const Gap(16),
  ],
);