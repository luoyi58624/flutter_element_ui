import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Increment extends Intent {}

class Decrement extends Intent {}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    final show = useState(true);
    final activeIndex = useObs(2);
    final tabs = useObs(
      [
        const ElGoogleTab(title: '标签页西那卡塞苏你显卡'),
        const ElGoogleTab(title: 'axasxa'),
        const ElGoogleTab(title: 'xasx'),
        const ElGoogleTab(title: 'xasxasxasxasxas'),
        ...List.generate(
          5,
          (index) => ElGoogleTab(title: '标签页 - ${index + 1}'),
        ),
      ],
    );
    final listData = useState<List<Widget>>([
      Container(
        width: 200,
        height: 100,
        color: Colors.green,
      ),
      // Container(
      //   width: 100,
      //   height: 100,
      //   color: Colors.red,
      // ),
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          if (context.sm)
            ObsBuilder(builder: (context) {
              return Switch(
                value: GlobalState.isDark.value,
                onChanged: (v) => GlobalState.isDark.value = v,
              );
            }),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Shortcuts(
                shortcuts: {
                  LogicalKeySet(
                    // LogicalKeyboardKey.control,
                    LogicalKeyboardKey.keyR,
                  ): Increment(),
                  LogicalKeySet(LogicalKeyboardKey.home): Decrement(),
                },
                child: Actions(
                  actions: {
                    Increment: CallbackAction<Increment>(
                      onInvoke: (intent) => () {
                        count.value++;
                      }(),
                    ),
                    Decrement: CallbackAction<Decrement>(
                      onInvoke: (intent) => () {
                        count.value--;
                      }(),
                    ),
                  },
                  child: ElButton(
                    onPressed: () {
                      count.value++;
                    },
                    child: 'count: ${count.value}',
                    type: 'primary',
                  ),
                ),
              ),
              _CupertinoSegment(),
              ElGoogleTabs(
                activeIndex,
                // duration: 1000.ms,
                // enabledAnimate: false,
                children: tabs,
              ),
              // ElButton(
              //   onPressed: () {
              //     count.value++;
              //   },
              //   child: 'count: ${count.value}',
              // ),
              // ElButton(
              //   onPressed: () {
              //     listData.value = [
              //       ...listData.value,
              //       HoverBuilder(builder: (context) {
              //         return Container(
              //           width: 300,
              //           height: 200,
              //           color: HoverBuilder.of(context)
              //               ? Colors.red
              //               : Colors.green,
              //         );
              //       })
              //     ];
              //     // show.value = !show.value;
              //   },
              //   child: '切换',
              // ),
              // // ...listData.value,
              // CustomMultiChildLayoutWidget(
              //   height: 600,
              //   delegateBuilder: (updateSize) =>
              //       _D(updateSize, listData.value.length),
              //   children: listData.value
              //       .mapIndexed((i, e) => LayoutId(id: i, child: e))
              //       .toList(),
              // ),
              // ElButton(
              //   onPressed: () {
              //     if (listData.value.isEmpty) return;
              //     listData.value =
              //         listData.value.sublist(0, listData.value.length - 1);
              //     // show.value = !show.value;
              //   },
              //   child: '切换',
              // ),
              // const Gap(8),
              // _Box(
              //   color: show.value ? Colors.red : Colors.blue,
              // ),

              // HoverBuilder(builder: (context) {
              //   return const Text('hello')
              //       .animate(target: show.value ? 1 : 0)
              //       .fade(duration: 200.ms);
              // }),
              // const Gap(50),
              // TapBuilder(builder: (context) {
              //   return Container(
              //     width: 100,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ).animate(target: context ? 1 : 0).scale(
              //         duration: 200.ms,
              //         curve: Curves.easeOut,
              //         begin: const Offset(1.0, 1.0),
              //         end: const Offset(0.9, 0.9),
              //       );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

class _CupertinoSegment extends StatefulWidget {
  const _CupertinoSegment({super.key});

  @override
  State<_CupertinoSegment> createState() => _CupertinoSegmentState();
}

class _CupertinoSegmentState extends State<_CupertinoSegment> {
  Sky _selectedSegment = Sky.midnight;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      backgroundColor: CupertinoColors.systemGrey2,
      thumbColor: skyColors[_selectedSegment]!,
      // This represents the currently selected segmented control.
      groupValue: _selectedSegment,
      // Callback that sets the selected segmented control.
      onValueChanged: (Sky? value) {
        if (value != null) {
          setState(() {
            _selectedSegment = value;
          });
        }
      },
      children: const <Sky, Widget>{
        Sky.midnight: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Midnight',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Sky.viridian: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Viridian',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Sky.cerulean: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Cerulean',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}
