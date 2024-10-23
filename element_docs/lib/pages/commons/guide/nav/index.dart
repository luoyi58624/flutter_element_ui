import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const _Example(),
    ];
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selected = useState(-1);
    final loading = useState(false);

    return Column(
      children: [
        ElText(selected.value),
        ElButtonTheme(
          data: ElButtonThemeData(
            borderBuilder: (state) => Border.all(
              width: state.isHover || state.isTap ? 1.5 : 1.0,
              color: state.color,
            ),
          ),
          child: ElButtonGroup(
            selected,
            children: [
              ElButton(
                onPressed: () {
                  loading.value = true;
                  setTimeout(() {
                    loading.value = false;
                  }, 1000);
                },
                child: '选项一',
                loading: loading.value,
              ),
              ElButton(child: '选项二'),
            ],
          ),
        ),
      ],
    );
  }
}
