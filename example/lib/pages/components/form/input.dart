import 'package:example/global.dart';
import 'package:flutter/widgets.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    // f.TextBox();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: 640,
          child: ElForm(
            data: formData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  ElInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
