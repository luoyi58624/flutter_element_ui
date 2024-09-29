import 'package:flutter/material.dart';

class MultiChildTestPage extends StatelessWidget {
  const MultiChildTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义布局测试'),
      ),
      body: UnconstrainedBox(
        child: Container(
          margin: const EdgeInsets.all(50),
          constraints: const BoxConstraints(
            maxWidth: 400,
            minHeight: 50,
            maxHeight: 200,
          ),
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          // child: Text('text'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: Text('text' * 2),
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            ],
          ),
          // child: _Layout(),
        ),
      ),
    );
  }
}

// class _Layout extends StatelessWidget {
//   const _Layout({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomMultiChildLayout(
//       delegate: _Delegate(),
//       children: [
//         LayoutId(
//           id: 1,
//           child: UnconstrainedBox(
//             child: Container(
//               width: 50,
//               height: 50,
//               color: Colors.grey,
//             ),
//           ),
//         ),
//         LayoutId(
//           id: 2,
//           child: Container(
//             width: 100,
//             height: 50,
//             color: Colors.green,
//             child: Text('xxx' * 5),
//           ),
//         ),
//         LayoutId(
//           id: 3,
//           child: Container(
//             width: 50,
//             height: 50,
//             color: Colors.red,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _Delegate extends MultiChildLayoutDelegate {
//   @override
//   void performLayout(Size size) {
//     final firstSize = layoutChild(1, BoxConstraints.loose(size));
//     final twoSize = layoutChild(2, BoxConstraints.loose(size));
//     layoutChild(3, BoxConstraints.loose(size));
//     positionChild(2, Offset(firstSize.width, 0));
//     positionChild(3, Offset(firstSize.width + twoSize.width, 0));
//   }
//
//   @override
//   bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
//     return false;
//   }
// }
