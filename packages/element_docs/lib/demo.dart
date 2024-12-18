import 'package:element_docs/global.dart';
import 'package:element_docs/hooks/simple_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MenuSelection {
  about,
  showMessage,
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: PlatformMenuBarExample()),
    );
  }
}

class PlatformMenuBarExample extends StatefulWidget {
  const PlatformMenuBarExample({super.key});

  @override
  State<PlatformMenuBarExample> createState() => _PlatformMenuBarExampleState();
}

class _PlatformMenuBarExampleState extends State<PlatformMenuBarExample> {
  String _message = 'Hello';
  bool _showMessage = false;

  void _handleMenuSelection(MenuSelection value) {
    switch (value) {
      case MenuSelection.about:
        showAboutDialog(
          context: context,
          applicationName: 'MenuBar Sample',
          applicationVersion: '1.0.0',
        );
      case MenuSelection.showMessage:
        setState(() {
          _showMessage = !_showMessage;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////
    // THIS SAMPLE ONLY WORKS ON MACOS.
    ////////////////////////////////////

    // This builds a menu hierarchy that looks like this:
    // Flutter API Sample
    //  ├ About
    //  ├ ────────  (group divider)
    //  ├ Hide/Show Message
    //  ├ Messages
    //  │  ├ I am not throwing away my shot.
    //  │  └ There's a million things I haven't done, but just you wait.
    //  └ Quit
    return PlatformMenuBar(
      menus: <PlatformMenuItem>[
        PlatformMenu(
          label: 'Flutter API Sample',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'About',
                  onSelected: () {
                    _handleMenuSelection(MenuSelection.about);
                  },
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  onSelected: () {
                    _handleMenuSelection(MenuSelection.showMessage);
                  },
                  shortcut: const CharacterActivator('m'),
                  label: _showMessage ? 'Hide Message' : 'Show Message',
                ),
                PlatformMenu(
                  label: 'Messages',
                  menus: <PlatformMenuItem>[
                    PlatformMenuItem(
                      label: 'I am not throwing away my shot.',
                      shortcut: const SingleActivator(LogicalKeyboardKey.digit1,
                          meta: true),
                      onSelected: () {
                        setState(() {
                          _message = 'I am not throwing away my shot.';
                        });
                      },
                    ),
                    PlatformMenuItem(
                      label:
                          "There's a million things I haven't done, but just you wait.",
                      shortcut: const SingleActivator(LogicalKeyboardKey.digit2,
                          meta: true),
                      onSelected: () {
                        setState(() {
                          _message =
                              "There's a million things I haven't done, but just you wait.";
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            // if (PlatformProvidedMenuItem.hasMenu(
            //     PlatformProvidedMenuItemType.quit))
            //   const PlatformProvidedMenuItem(
            //     type: PlatformProvidedMenuItemType.quit,
            //   ),
          ],
        ),
      ],
      child: Center(
        child: Text(_showMessage
            ? _message
            : 'This space intentionally left blank.\n'
                'Show a message here using the menu.'),
      ),
    );
  }
}
