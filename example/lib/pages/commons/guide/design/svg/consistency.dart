import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConsistencySvg extends StatelessWidget {
  const ConsistencySvg({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(_svgStr);
  }
}

const String _svgStr = '''
<?xml version="1.0" encoding="utf-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="图层_1" version="1.1" x="0px" y="0px" viewBox="0 0 79 79" style="enable-background: new 0 0 79 79" xml:space="preserve">
  <circle fill="#eff5fd" cx="39.5" cy="39.5" r="39.5"/>
  <path fill="#0077ce" d="M23.2,42c-0.5,0-1,0.4-1,1v17.8c0,0.5,0.4,1,1,1h3.5c0.5,0,1-0.4,1-1V43c0-0.5-0.4-1-1-1H23.2z"/>
  <path fill="#0077ce" d="M32.6,42c-0.5,0-1,0.4-1,1v17.8c0,0.5,0.4,1,1,1H36c0.5,0,1-0.4,1-1V43c0-0.5-0.4-1-1-1H32.6z"/>  
  <path fill="#0077ce" d="M42,43c0-0.5,0.4-1,1-1h3.5c0.5,0,1,0.4,1,1v17.8c0,0.5-0.4,1-1,1H43c-0.5,0-1-0.4-1-1V43z"/>
  <path fill="#0077ce" d="M52.3,42c-0.5,0-1,0.4-1,1v17.8c0,0.5,0.4,1,1,1h3.5c0.5,0,1-0.4,1-1V43c0-0.5-0.4-1-1-1H52.3z"/>
  <path fill="#20a0ff" d="M22.2,43c0-0.5,0.4-1,1-1h3.5c0.5,0,1,0.4,1,1v15.8c0,0.5-0.4,1-1,1h-3.5c-0.5,0-1-0.4-1-1V43z"/>
  <path fill="#20a0ff" d="M31.6,43c0-0.5,0.4-1,1-1H36c0.5,0,1,0.4,1,1v15.8c0,0.5-0.4,1-1,1h-3.5c-0.5,0-1-0.4-1-1V43z"/>
  <path fill="#20a0ff" d="M42,43c0-0.5,0.4-1,1-1h3.5c0.5,0,1,0.4,1,1v15.8c0,0.5-0.4,1-1,1H43c-0.5,0-1-0.4-1-1V43z"/>
  <path fill="#20a0ff" d="M51.3,43c0-0.5,0.4-1,1-1h3.5c0.5,0,1,0.4,1,1v15.8c0,0.5-0.4,1-1,1h-3.5c-0.5,0-1-0.4-1-1V43z"/>
  <path fill="#7383bf" d="M57.3,28.1l-5.9-5.9v4.9H22.7c-0.5,0-1,0.4-1,1c0,0.5,0.4,1,1,1h28.6v4.9L57.3,28.1z"/>
</svg>
    ''';
