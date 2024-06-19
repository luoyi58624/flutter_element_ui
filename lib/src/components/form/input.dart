import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';

class ElInput extends StatefulWidget {
  const ElInput({super.key});

  @override
  State<ElInput> createState() => _ElInputState();
}

class _ElInputState extends State<ElInput> {
  final TextEditingController controller = TextEditingController(text: '初始文本');
  final FocusNode focusNode = FocusNode();

  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (hasFocus == false) {
          setState(() {
            hasFocus = true;
          });
        }
      } else {
        if (hasFocus == true) {
          setState(() {
            hasFocus = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return TextField();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 36,
      // padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: hasFocus
                ? context.elTheme.primary
                : context.elTheme.borderColor),
        borderRadius: BorderRadius.circular(context.elConfig.inputRadius),
      ),
      child: RepaintBoundary(
        child: EditableText(
          controller: controller,
          focusNode: focusNode,
          expands: true,
          minLines: null,
          maxLines: null,
          style: TextStyle(
            color: context.elTheme.textColor,
            // height: 1.8,
          ),
          // strutStyle: const StrutStyle(
          //   forceStrutHeight: true,
          // ),
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          cursorColor: context.elTheme.textColor,
          cursorWidth: 1,
          // cursorHeight: 18,
          // cursorOffset: const Offset(0, 3),
          backgroundCursorColor: context.elTheme.info.withOpacity(0.6),
          selectionColor: context.elTheme.primary.withOpacity(0.6),
          // enableInteractiveSelection: true,
          // enableSuggestions: false,
          // enableIMEPersonalizedLearning: true,
          // showSelectionHandles: false,
          // selectionControls: MaterialTextSelectionControls(),
          // selectionHeightStyle: BoxHeightStyle.includeLineSpacingMiddle,
          // dragStartBehavior: DragStartBehavior.start,
          onSelectionChanged: (selection, cause) {},
        ),
      ),
    );
  }
}

// class CustomTextSelected extends TextSelectionControls {
//   /// Fluent has no text selection handles.
//   @override
//   Size getHandleSize(double textLineHeight) {
//     return Size.zero;
//   }
//
//   @override
//   Widget buildToolbar(
//     BuildContext context,
//     Rect globalEditableRegion,
//     double textLineHeight,
//     Offset selectionMidpoint,
//     List<TextSelectionPoint> endpoints,
//     TextSelectionDelegate delegate,
//     ValueListenable<ClipboardStatus>? clipboardStatus,
//     Offset? lastSecondaryTapDownPosition,
//   ) {
//     return SizedBox();
//     // return _FluentTextSelectionControlsToolbar(
//     //   clipboardStatus: clipboardStatus,
//     //   endpoints: endpoints,
//     //   globalEditableRegion: globalEditableRegion,
//     //   handleCut: canCut(delegate) ? () => handleCut(delegate) : null,
//     //   handleCopy: canCopy(delegate) ? () => handleCopy(delegate) : null,
//     //   handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : null,
//     //   handleSelectAll:
//     //   canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
//     //   selectionMidpoint: selectionMidpoint,
//     //   lastSecondaryTapDownPosition: lastSecondaryTapDownPosition,
//     //   textLineHeight: textLineHeight,
//     // );
//   }
//
//   /// Builds the text selection handles, but desktop has none.
//   @override
//   Widget buildHandle(
//     BuildContext context,
//     TextSelectionHandleType type,
//     double textLineHeight, [
//     VoidCallback? onTap,
//     double? startGlyphHeight,
//     double? endGlyphHeight,
//   ]) {
//     return SizedBox();
//   }
//
//   /// Gets the position for the text selection handles, but desktop has none.
//   @override
//   Offset getHandleAnchor(
//     TextSelectionHandleType type,
//     double textLineHeight, [
//     double? startGlyphHeight,
//     double? endGlyphHeight,
//   ]) {
//     return Offset.zero;
//   }
//
//   @override
//   bool canSelectAll(TextSelectionDelegate delegate) {
//     // Allow SelectAll when selection is not collapsed, unless everything has
//     // already been selected. Same behavior as Android.
//     final value = delegate.textEditingValue;
//     return delegate.selectAllEnabled &&
//         value.text.isNotEmpty &&
//         !(value.selection.start == 0 && value.selection.end == value.text.length);
//   }
// }
