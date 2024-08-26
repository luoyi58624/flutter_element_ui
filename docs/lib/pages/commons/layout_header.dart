import 'package:docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutHeader extends StatelessWidget {
  const LayoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          ElLink(
            href: '/',
            child: GestureDetector(
              onTapDown: (e) {
                context.go('/');
              },
              child: ElIcon(
                'assets/images/element-plus-logo.svg',
                color: context.elTheme.primary,
                size: 28,
                package: null,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              buildDesktopNav(context),
              const Gap(16),
              ObsBuilder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    GlobalState.isDark = !GlobalState.isDark;
                  },
                  icon: Icon(
                    GlobalState.isDark ? Icons.dark_mode : Icons.light_mode,
                  ),
                  color: context.elTheme.iconColor,
                );
              }),
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.settings),
              ),
              ElLink(
                href: 'https://github.com/luoyi58624/flutter_element_ui',
                child: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      ElLink.to(context);
                    },
                    icon: const _GithubLogo(),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDesktopNav(BuildContext context) {
    return context.sm
        ? const SizedBox()
        : ObsBuilder(
            watch: [RouterUtil.currentPath],
            builder: (context) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...RootRoute.values.map(
                    (e) => ElLink(
                      href: '/${e.$2}',
                      child: Builder(builder: (context) {
                        return GestureDetector(
                          onTapDown: (e) {
                            context.go(ElLink.getHref(context)!);
                          },
                          child: HoverBuilder(
                            cursor: SystemMouseCursors.click,
                            builder: (context) {
                              final isActive = RouterUtil.currentPath.value
                                  .startsWith('/${e.$2}');
                              return Stack(
                                children: [
                                  Container(
                                    height: el.config.headerHeight,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Center(
                                      child: H6(
                                        e.$1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HoverBuilder.of(context)
                                                ? context.elTheme.primary
                                                : null),
                                      ),
                                    ),
                                  ),
                                  if (isActive)
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: context.elTheme.primary,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  )
                ],
              );
            });
  }
}

class _GithubLogo extends StatelessWidget {
  const _GithubLogo();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '''<svg height="32" aria-hidden="true" viewBox="0 0 24 24" version="1.1" width="32" data-view-component="true" class="octicon octicon-mark-github v-align-middle color-fg-default">
    <path d="M12.5.75C6.146.75 1 5.896 1 12.25c0 5.089 3.292 9.387 7.863 10.91.575.101.79-.244.79-.546 0-.273-.014-1.178-.014-2.142-2.889.532-3.636-.704-3.866-1.35-.13-.331-.69-1.352-1.18-1.625-.402-.216-.977-.748-.014-.762.906-.014 1.553.834 1.769 1.179 1.035 1.74 2.688 1.25 3.349.948.1-.747.402-1.25.733-1.538-2.559-.287-5.232-1.279-5.232-5.678 0-1.25.445-2.285 1.178-3.09-.115-.288-.517-1.467.115-3.048 0 0 .963-.302 3.163 1.179.92-.259 1.897-.388 2.875-.388.977 0 1.955.13 2.875.388 2.2-1.495 3.162-1.179 3.162-1.179.633 1.581.23 2.76.115 3.048.733.805 1.179 1.825 1.179 3.09 0 4.413-2.688 5.39-5.247 5.678.417.36.776 1.05.776 2.128 0 1.538-.014 2.774-.014 3.162 0 .302.216.662.79.547C20.709 21.637 24 17.324 24 12.25 24 5.896 18.854.75 12.5.75Z"></path>
</svg>''',
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        context.elTheme.iconColor,
        BlendMode.srcIn,
      ),
    );
  }
}