// class _Example extends HookWidget {
//   const _Example();
//
//   @override
//   Widget build(BuildContext context) {
//     const TextStyle textStyle = TextStyle(fontSize: 12);
//     return Center(
//       child: Column(
//         children: [
//           ElListener(
//             onPointerDown: (e) {
//               w('parent');
//             },
//             child: Container(
//               width: 300,
//               height: 300,
//               color: Colors.green,
//               child: Center(
//                 child: ElStopPropagation(
//                   child: ElTap(
//                     onTapDown: (e) {
//                       i('child');
//                     },
//                     builder: (context) => Container(
//                       width: 200,
//                       height: 200,
//                       color: Colors.red,
//                       child: const Center(
//                         child: ElText(
//                           'ElListener, ElListener',
//                           style: textStyle,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Gap(8),
//           ElTap(
//             onTap: () {
//               w('parent');
//             },
//             builder: (context) {
//               return Container(
//                 width: 300,
//                 height: 300,
//                 color: Colors.green,
//                 child: Builder(builder: (context) {
//                   return Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         i('child');
//                       },
//                       child: Container(
//                         width: 200,
//                         height: 200,
//                         color: Colors.red,
//                         child: const Center(
//                           child: ElText(
//                             'ElTap, GestureDetector',
//                             style: textStyle,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             },
//           ),
//           const Gap(8),
//           GestureDetector(
//             onTap: () {
//               w('parent');
//             },
//             child: Container(
//               width: 300,
//               height: 300,
//               color: Colors.green,
//               child: Center(
//                 child: ElTap(
//                   onTap: () {
//                     i('child');
//                   },
//                   builder: (context) => Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.red,
//                     child: const Center(
//                       child: ElText(
//                         'GestureDetector, ElTap',
//                         style: textStyle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Gap(8),
//           GestureDetector(
//             onTap: () {
//               w('parent');
//             },
//             child: Container(
//               width: 300,
//               height: 300,
//               color: Colors.green,
//               child: Center(
//                 child: AbsorbPointer(
//                   child: GestureDetector(
//                     onTap: () {
//                       i('child');
//                     },
//                     child: Container(
//                       width: 200,
//                       height: 200,
//                       color: Colors.red,
//                       child: const Center(
//                         child: ElText(
//                           'GestureDetector, GestureDetector',
//                           style: textStyle,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Gap(8),
//           Stack(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   w('parent');
//                 },
//                 child: Container(
//                   width: 300,
//                   height: 300,
//                   color: Colors.green,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   i('child');
//                 },
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.red,
//                   child: const Center(
//                     child: ElText(
//                       'Stack - GestureDetector, GestureDetector',
//                       style: textStyle,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Gap(8),
//           Stack(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   w('parent');
//                 },
//                 child: Container(
//                   width: 300,
//                   height: 300,
//                   color: Colors.green,
//                 ),
//               ),
//               IgnorePointer(
//                 child: GestureDetector(
//                   onTap: () {
//                     i('child');
//                   },
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.red,
//                     child: const Center(
//                       child: ElText(
//                         'Stack - GestureDetector, GestureDetector',
//                         style: textStyle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Gap(8),
//           Stack(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   w('parent');
//                 },
//                 child: Container(
//                   width: 300,
//                   height: 300,
//                   color: Colors.green,
//                 ),
//               ),
//               IgnorePointer(
//                 child: ElTap(
//                   onTap: () {
//                     i('child');
//                   },
//                   builder: (context) => Container(
//                     width: 200,
//                     height: 200,
//                     color: Colors.red,
//                     child: const Center(
//                       child: ElText(
//                         'Stack - GestureDetector, GestureDetector',
//                         style: textStyle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
