// import 'package:flutter/widgets.dart';
//
// import '../../../basic/text.dart';
// import '../index.dart';
//
// class ElDefaultTabs2 extends StatelessWidget {
//   const ElDefaultTabs2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final $data = ElTabs.of(context);
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Container(
//         height: $data.themeData.size,
//         decoration: const BoxDecoration(),
//         child: Row(
//           children: [
//             ...$data.children.map(
//               (e) => Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Row(
//                   children: [
//                     ElText(e.title),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
