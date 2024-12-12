import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class CustomButton extends ElButton2 {
  const CustomButton({
    super.key,
    required super.child,
    super.disabled,
    super.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends ElButton2State<CustomButton> {
  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    return (
      bgColor: null,
      textColor: Colors.white,
      borderColor: null,
    );
  }

  @override
  BoxDecoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(sizePreset.radius!),
      gradient: context.hasTap
          ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple,
                Colors.blue,
              ],
            )
          : const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink,
                Colors.green,
              ],
            ),
    );
  }

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(sizePreset.radius!),
      child: super.buildButtonWrapper(context, child),
    );
  }

  @override
  Widget buildButtonContent(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: super.buildButtonContent(context),
    );
  }
}
