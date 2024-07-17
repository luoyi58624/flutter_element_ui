import 'package:flutter/material.dart';

class SliderTestPage extends StatefulWidget {
  const SliderTestPage({super.key});

  @override
  State<SliderTestPage> createState() => _SliderTestPageState();
}

class _SliderTestPageState extends State<SliderTestPage> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1000个Slider'),
      ),
      body: ListView(
        children: [
          ...List.generate(
            1000,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text((sliderValue.floor()).toString()),
                  Expanded(
                    child: Slider(
                      max: 100,
                      value: sliderValue,
                      onChanged: (v) {
                        setState(() {
                          sliderValue = v;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
