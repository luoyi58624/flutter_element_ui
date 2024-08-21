import 'package:docs/global.dart';
import 'package:docs/widgets/slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavPage extends HookWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      children: [
        ElSwitch(flag),
        AnimatedContainer(
          duration: 200.ms,
          color: el.isDark ? el.darkTheme.bgColor : el.lightTheme.bgColor,
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        Material(
          animationDuration: 1000.ms,
          color: flag.value ? el.darkTheme.bgColor : el.lightTheme.bgColor,
          surfaceTintColor:
              flag.value ? el.darkTheme.bgColor : el.lightTheme.bgColor,
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        Material(
          animationDuration: 1000.ms,
          color: el.isDark ? el.darkTheme.bgColor : el.lightTheme.bgColor,
          surfaceTintColor:
              el.isDark ? el.darkTheme.bgColor : el.lightTheme.bgColor,
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        Card(
          elevation: 4,
          color: flag.value ? Colors.blue : Colors.green,
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        ),
        Card(
          elevation: 4,
          color: el.isDark ? Colors.blue : Colors.green,
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: el.theme.bgColor,
      appBar: AppBar(
        title: const Text('hello'),
      ),
      body: Container(),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    const String svgStr = '''
<?xml version="1.0" encoding="utf-8"?>

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 153.71 38">
  <defs>
    <style>.cls-1,.cls-2{fill: #4A7FFB;}.cls-1{fill-rule:evenodd;}</style>
  </defs>
  <title>资源 1</title>
  <g id="图层_2" data-name="图层 2">
    <g id="图层_1-2" data-name="图层 1">
      <path id="Shape-Copy" class="cls-1" d="M142,26.16s.28,0,.82,0a.72.72,0,0,1,.69.41s1.08,2,1.37,2.48,0,.42-.12.41h0s-.31,0-3.45,0a4.93,4.93,0,0,1-4.54-4.54v-7H134.3V15.28c0-.36.41-.41.41-.41h2.07V12.25a.6.6,0,0,1,.41-.55l2.3-.66c.34-.1.59,0,.59.35V15h3.58c.34,0,.41.41.41.41V18h-4v6.06c0,1.76,1.93,2.07,1.93,2.07Zm-10.6,3h-2.2c-.43,0-.41-.55-.41-.55V18.45c0-.62-.83-.83-.83-.83h-4.54c-.68,0-.69.83-.69.83V28.77a.41.41,0,0,1-.41.42h-2.2c-.48,0-.41-.55-.41-.55V15.83c0-1,1.24-1.24,1.24-1.24h9.63c1,0,1.23,1.24,1.23,1.24V28.5c0,.72-.41.69-.41.69ZM115.73,23.4H107.2v2.07c0,.74,1,1,1,1H115a1.16,1.16,0,0,1,.82.42s.61,1.25.83,1.79-.41.55-.41.55H106c-1.24,0-1.51-1.52-1.51-1.52V16c0-.67,1-1,1-1h10.32c1,0,1.24,1.23,1.24,1.23v5.93c0,1-1.24,1.23-1.24,1.23Zm-1.52-4.95s-.08-.69-.68-.69h-5.65s-.68.18-.68.69V20a.69.69,0,0,0,.68.69h5.65a.9.9,0,0,0,.68-.83V18.45ZM101.28,29.19h-2.2c-.29,0-.41-.42-.41-.42V18.45c0-.64-.83-.83-.83-.83H95.78c-.58,0-.69.83-.69.83V28.77c0,.35-.41.42-.41.42h-2.2c-.31,0-.42-.42-.42-.42V18.45c0-.66-.82-.83-.82-.83H89.17c-.63,0-.68.83-.68.83V28.77a.39.39,0,0,1-.42.42h-2.2a.41.41,0,0,1-.41-.42V15.69c0-.75,1.1-1.1,1.1-1.1h13.76c1.1,0,1.37,1.38,1.37,1.38v12.8c0,.48-.41.42-.41.42Zm-20-5.79H72.8v2.07c0,.74,1,1,1,1h6.88a1.19,1.19,0,0,1,.83.42s.6,1.25.82,1.79-.41.55-.41.55H71.56c-1.24,0-1.51-1.52-1.51-1.52V16c0-.67,1-1,1-1H81.33c1,0,1.24,1.23,1.24,1.23v5.93c0,1-1.24,1.23-1.24,1.23Zm-1.51-4.95s-.09-.69-.69-.69H73.49s-.69.18-.69.69V20a.69.69,0,0,0,.69.69h5.64a.91.91,0,0,0,.69-.83V18.45ZM68,29.19H62.76a4.35,4.35,0,0,1-4.13-4c0-3.91,0-16.1,0-16.1h2.48a.79.79,0,0,1,.82.82V24.37A2.58,2.58,0,0,0,63.86,26h2.2s.72-.23,1.24.69l1.1,1.93s.08.55-.41.55Zm-26.56-.83V10.19a1,1,0,0,1,.69-1H55.05c.73,0,.42.83.42.83s-.41,1.12-.69,1.65a1,1,0,0,1-.83.55H45.56a.77.77,0,0,0-.83.69v4.54h9.5c.55,0,.27.69.27.69s-.71,1.52-1,1.93a1.05,1.05,0,0,1-.83.41h-8v4.82a.91.91,0,0,0,.69.83h8.81a.85.85,0,0,1,.82.41l1.24,1.93c.37.56-.14.69-.14.69H42.26C41.68,29.19,41.43,28.36,41.43,28.36Zm-8.14-1.14c0,1.57-.83,1.93-.83,1.93S18.32,37.31,17.4,37.83a1.68,1.68,0,0,1-1.52,0S1.09,29.25.55,28.87a1.29,1.29,0,0,1-.55-1s0-17,0-17.78S1,8.76,1,8.76L15.75.21a2,2,0,0,1,1.79,0S30.6,7.8,32,8.62a2.08,2.08,0,0,1,1.25,2.06s0,15.07,0,16.54Zm-5.9-17c-3-1.74-10.16-5.87-10.16-5.87a1.58,1.58,0,0,0-1.41,0L4.22,11s-.77.46-.76,1.08S3.46,26,3.46,26a1,1,0,0,0,.43.75c.43.3,12,7,12,7a1.3,1.3,0,0,0,1.19,0c.72-.4,11.82-6.79,11.82-6.79s.65-.28.65-1.51c0-.36,0-1.74,0-3.47L16.53,29.88v-3a3,3,0,0,1,1-2.07l11.56-7a2.49,2.49,0,0,0,.55-1.46c0-1.27,0-2.37,0-3.07L16.53,21.2V18a2.17,2.17,0,0,1,.83-1.79Z"/>
      <path class="cls-1" d="M150.32,11.21h-2.24v-5c0-.11.12-.21.29-.24l1.44-.26c.26,0,.51.07.51.24Z"/>
      <path class="cls-1" d="M148.08,9h2.24v5.11c0,.11-.11.21-.28.25l-1.45.26c-.26.05-.51-.07-.51-.24Z"/>
      <path class="cls-2" d="M145.09,9h8.22a.4.4,0,0,1,.4.4v1.85a0,0,0,0,1,0,0h-9a0,0,0,0,1,0,0V9.36A.4.4,0,0,1,145.09,9Z"/>
    </g>
  </g>
</svg>
''';

    return SvgPicture.string(
      svgStr,
      // colorFilter: ColorFilter.mode(
      //   '#4A7FFB'.toColor(),
      //   BlendMode.srcIn,
      // ),
    );
  }
}
