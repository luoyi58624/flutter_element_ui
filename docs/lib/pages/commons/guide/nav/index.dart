import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final count = useState(0);

    final disabled = useState(false);
    final loading = useState(false);

    final childWidth = useObs(0.0);
    final username = useState('');
    return [
      // ElButton(
      //   onPressed: () {
      //     count.value++;
      //   },
      //   child: ElText('count: ${count.value}'),
      // ),
      // ElevatedButton(
      //   onPressed: () {
      //     count.value++;
      //   },
      //   child: Text('count: ${count.value}'),
      // ),
      const Gap(8),
      Link(
        uri: Uri.parse('https://www.baidu.com'),
        builder: (context, open) => ElButton(
          onPressed: (){
            open!();
          },
          type: 'primary',
          link: true,
          child: '链接',
        ),
      ),
      const Gap(8),
      Link(
        uri: Uri.parse('/component/button'),
        builder: (context, open) => ElButton(
          onPressed: (){
            open!();
          },
          type: 'primary',
          link: true,
          child: '按钮页面',
        ),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          count.value++;
        },
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),

      ElButton(
        onPressed: () {
          count.value++;
        },
        type: 'primary',
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          count.value++;
        },
        type: 'primary',
        plain: true,
        child: const ElText('提 交'),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          count.value++;
        },
        type: 'primary',
        child: const ElText(''),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          disabled.value = true;
          () {
            disabled.value = false;
          }.delay(1500);
        },
        disabled: disabled.value,
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          loading.value = true;
          () {
            loading.value = false;
          }.delay(1500);
        },
        loading: loading.value,
        child: ElText('count: ${count.value}'),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          loading.value = true;
          () {
            loading.value = false;
          }.delay(1500);
        },
        type: 'primary',
        loading: loading.value,
        child: ElText('count: ${count.value}'),
      ),
    ];
  }
}
