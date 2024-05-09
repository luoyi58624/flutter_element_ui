import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontPage extends StatelessWidget {
  const FontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
            children: FontWeight.values
                .map((e) => Text(
                      'hello，你好呀 - ${e.value}',
                      style: TextStyle(fontWeight: e),
                    ))
                .toList()),
        SizedBox(width: 16),
        Column(
            children: FontWeight.values
                .map((e) => Text(
                      'hello，你好呀 - ${e.value}',
                      style: TextStyle(fontWeight: e, fontSize: 18),
                    ))
                .toList()),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.robotoMono(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.robotoSerif(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.robotoSlab(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.lato(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Column(
        //     children: FontWeight.values
        //         .map((e) => Text(
        //       'hello，你好呀 - ${e.value}',
        //       style: GoogleFonts.acme(textStyle: TextStyle(fontWeight: e)),
        //     ))
        //         .toList()),
        // SizedBox(width: 16),
        // Expanded(
        //   child: Scaffold(
        //     body: Column(
        //       children: FontWeight.values
        //           .map(
        //             (e) => Text(
        //               'hello，你好呀 - ${e.value}',
        //               style: TextStyle(fontWeight: e),
        //             ),
        //           )
        //           .toList(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
