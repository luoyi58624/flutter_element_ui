import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class BorderTestPage extends StatefulWidget {
  const BorderTestPage({super.key});

  @override
  State<BorderTestPage> createState() => _BorderTestPageState();
}

class _BorderTestPageState extends State<BorderTestPage> {
  late BorderSide borderSide = BorderSide(color: ElAppData.of(context).currentTheme.defaultBorderColor);
  bool selectIndex1 = false;
  bool selectIndex2 = false;
  bool selectIndex3 = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: borderSide,
                    bottom: borderSide,
                    left: borderSide,
                    right: borderSide,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text('Item 1'),
                ),
              ),
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: borderSide,
                    bottom: borderSide,
                    right: borderSide,
                  ),
                ),
                child: Center(
                  child: Text('Item 2'),
                ),
              ),
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: borderSide,
                    bottom: borderSide,
                    right: borderSide,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text('Item 3'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex1 = !selectIndex1;
                  });
                },
                child: Container(
                  height: 32,
                  padding: EdgeInsets.only(left: selectIndex1 ? 17 : 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: selectIndex1 ? BorderSide.none : borderSide,
                      bottom: selectIndex1 ? BorderSide.none : borderSide,
                      left: selectIndex1 ? BorderSide.none : borderSide,
                      right: selectIndex1 ? const BorderSide(color: Colors.white) : borderSide,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: selectIndex1 ? Colors.green : null,
                  ),
                  child: Center(
                    child: Text(
                      'Item 1',
                      style: TextStyle(
                        color: selectIndex1 ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex2 = !selectIndex2;
                  });
                },
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: selectIndex2 ? BorderSide.none : borderSide,
                      bottom: selectIndex2 ? BorderSide.none : borderSide,
                      right: selectIndex2 ? const BorderSide(color: Colors.white) : borderSide,
                    ),
                    color: selectIndex2 ? Colors.green : null,
                  ),
                  child: Center(
                    child: Text(
                      'Item 2',
                      style: TextStyle(
                        color: selectIndex2 ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex3 = !selectIndex3;
                  });
                },
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: selectIndex3 ? BorderSide.none : borderSide,
                      bottom: selectIndex3 ? BorderSide.none : borderSide,
                      right: selectIndex3 ? BorderSide.none : borderSide,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: selectIndex3 ? Colors.green : null,
                  ),
                  child: Center(
                    child: Text(
                      'Item 3',
                      style: TextStyle(
                        color: selectIndex3 ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
