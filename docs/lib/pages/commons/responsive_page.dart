import 'package:docs/global.dart';
import 'package:flutter/material.dart';

abstract class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  String get title;

  List<Widget> buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return context.sm
        ? Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: ColumnWidget(
              scroll: true,
              padding: const EdgeInsets.all(8),
              children: buildPage(context),
            ),
          )
        : SelectionArea(
            child: ColumnWidget(
              scroll: true,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              children: [
                const Gap(25),
                H1(title),
                const Gap(25),
                ...buildPage(context),
              ],
            ),
          );
  }
}
