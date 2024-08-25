import 'package:docs/global.dart';
import 'package:flutter/material.dart';



class QuickStartPage extends HookWidget {
  const QuickStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            H1('快速开始'),
            // ElInput(
            //   inputValue,
            //   minLines: 1,
            //   maxLines: 10,
            //   style: TextStyle(fontFamily: 'Consolas'),
            // ),
          ],
        ),
      ),
    );


  }
}


