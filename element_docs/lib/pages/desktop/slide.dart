import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../../router/router_config.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget(this.models, {super.key});

  final List<SlideRouteModelType> models;

  Color buildStatusColor(BuildContext context, WorkStatus status) {
    switch (status) {
      case WorkStatus.pending:
        return Colors.grey;
      case WorkStatus.processing:
        return Colors.blue;
      case WorkStatus.beta:
        return Colors.orange;
      case WorkStatus.finished:
        return Colors.green;
    }
  }

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
            children: models
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(16),
                      H5(e.$1),
                      const Gap(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: e.$2
                            .map(
                              (e) => ElLink(
                                href: e.$2,
                                disabledEvent: true,
                                child: Builder(builder: (context) {
                                  return GestureDetector(
                                    onTapDown: (e) {
                                      ElLink.to(context);
                                    },
                                    child: ObsBuilder(builder: (context) {
                                      final isActive =
                                          RouterState.currentPath.value == e.$2;
                                      return ElEvent(builder: (context) {
                                        return AnimatedContainer(
                                          duration: context.elDuration(),
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: isActive
                                                ? context.isDark
                                                    ? Colors.grey.shade800
                                                    : context.elTheme.primary
                                                        .mix(
                                                        Colors.white,
                                                        90,
                                                      )
                                                : null,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: buildStatusColor(
                                                    context,
                                                    e.$3,
                                                  ),
                                                ),
                                              ),
                                              const Gap(8),
                                              Expanded(
                                                child: ElText(
                                                  e.$1,
                                                  style: TextStyle(
                                                    color: context.isHover ||
                                                            isActive
                                                        ? context
                                                            .elTheme.primary
                                                        : context
                                                            .elTheme
                                                            .textTheme
                                                            .textStyle
                                                            .color,
                                                    fontSize: 0.875.rem,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    }),
                                  );
                                }),
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
