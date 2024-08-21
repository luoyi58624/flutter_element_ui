import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LayoutBasicPage extends StatelessWidget {
  const LayoutBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: el.theme.borderColor,
                  width: 4,
                ),
              ),
              child: const ElLayout(
                children: [
                  ElHeader(
                    child: Text('Header'),
                  ),
                  ElLayout(
                    children: [
                      ElAside(
                          child: SizedBox(
                        width: 240,
                        child: Text('Aside'),
                      )),
                      ElMain(
                        child: Text('Main'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(20),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: el.theme.borderColor,
                  width: 4,
                ),
              ),
              child: const ElLayout(
                children: [
                  ElAside(
                      child: SizedBox(
                    width: 240,
                    child: Text('Aside'),
                  )),
                  ElLayout(
                    children: [
                      ElHeader(
                        child: Text('Header'),
                      ),
                      ElMain(
                        child: Text('Main'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
