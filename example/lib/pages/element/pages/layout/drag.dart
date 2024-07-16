import 'package:example/global.dart';
import 'package:flutter/material.dart';

class LayoutDragPage extends StatefulWidget {
  const LayoutDragPage({super.key});

  @override
  State<LayoutDragPage> createState() => _LayoutDragPageState();
}

class _LayoutDragPageState extends State<LayoutDragPage> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        buildLayout('布局1', layout1()),
        // buildLayout('布局2', layout2()),
        // buildLayout('布局3', layout3()),
        buildLayout('布局4', layout4()),
        buildLayout('布局5', layout5()),
      ],
    );
  }

  Widget buildLayout(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [ElText(title), const Gap(8), child],
      ),
    );
  }

  Widget layout1() {
    return SizedBox(
      width: 300,
      height: 100,
      child: ElLayout(
        children: [
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.grey),
          ),
          const ElLayoutSplit(size: 1),
          ElMain(flex: 1, child: Container(color: Colors.purple)),
          const ElLayoutSplit(size: 1),
          ElMain(flex: 1, child: Container(color: Colors.purple)),
          // ElLayout(children: [
          //   ElMain(flex: 1, child: Container(color: Colors.green)),
          //   const ElLayoutSplit(size: 1),
          //   ElMain(flex: 1, child: Container(color: Colors.green)),
          // ]),
        ],
      ),
    );
  }

  Widget layout2() {
    return SizedBox(
      width: 450,
      height: 100,
      child: ElLayout(
        children: [
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.grey),
          ),
          const ElLayoutSplit(size: 1),
          ElMain(child: Container(color: Colors.green)),
          const ElLayoutSplit(size: 1),
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget layout3() {
    return SizedBox(
      width: 500,
      height: 100,
      child: ElLayout(
        children: [
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.grey),
          ),
          const ElLayoutSplit(size: 1),
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.purple),
          ),
          const ElLayoutSplit(size: 1),
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget layout4() {
    return SizedBox(
      width: 500,
      height: 100,
      child: ElLayout(
        children: [
          ElAside(
            layoutKey: 'aside-1',
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.grey),
          ),
          const ElLayoutSplit(size: 1),
          ElAside(
            layoutKey: 'aside-2',
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.purple),
          ),
          const ElLayoutSplit(size: 1),
          ElAside(
            layoutKey: 'aside-3',
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget layout5() {
    return SizedBox(
      width: 500,
      height: 100,
      child: ElLayout(
        children: [
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.grey),
          ),
          const ElLayoutSplit(size: 1),
          ElMain(
            child: Container(color: Colors.purple),
          ),
          const ElLayoutSplit(size: 1),
          ElAside(
            width: 150,
            minWidth: 0,
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
