import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class SlideWidget extends StatefulWidget {
  const SlideWidget(this.models, {super.key});

  final List<(String title, List<(String name, String path)> items)> models;

  @override
  State<SlideWidget> createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.models
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(16),
                      H4(e.$1),
                      const Gap(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: e.$2
                            .map(
                              (e) => A(
                                href: e.$2,
                                child: GestureDetector(
                                  onTapDown: (event) {
                                    context.go(e.$2);
                                  },
                                  child: ObsBuilder(builder: (context) {
                                    final isActive =
                                        RouterUtil.currentPath.value == e.$2;
                                    return HoverBuilder(builder: (context) {
                                      return Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: isActive
                                              ? context.elTheme.primary.mix(
                                                  Colors.white,
                                                  90,
                                                )
                                              : null,
                                        ),
                                        child: ElText(
                                          e.$1,
                                          style: TextStyle(
                                            color: HoverBuilder.of(context) ||
                                                    isActive
                                                ? context.elTheme.primary
                                                : Colors.grey.shade800,
                                            fontWeight: isActive
                                                ? FontUtil.medium
                                                : FontUtil.normal,
                                          ),
                                        ),
                                      );
                                    });
                                  }),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
