import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

class ElEditor extends StatefulWidget {
  const ElEditor({
    super.key,
    this.enabledMagnifier = true,
    this.onTap,
    this.onTapAlwaysCalled = false,
  });

  /// 移动端是否开启放大镜
  final bool enabledMagnifier;

  /// 点击事件
  final GestureTapCallback? onTap;

  ///
  final bool onTapAlwaysCalled;

  @override
  State<ElEditor> createState() => ElEditorState();
}

class ElEditorState extends State<ElEditor>
    implements TextSelectionGestureDetectorBuilderDelegate {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get forcePressEnabled => true;

  @override
  bool get selectionEnabled => true;

  EditableTextState get _editableText => editableTextKey.currentState!;

  late TextSelectionControls textSelectionControls;

  late _TextFieldSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _TextFieldSelectionGestureDetectorBuilder(state: this);
    if (PlatformUtil.isAndroid || PlatformUtil.isFuchsia) {
      textSelectionControls = materialTextSelectionHandleControls;
    } else if (PlatformUtil.isIOS) {
      textSelectionControls = cupertinoTextSelectionHandleControls;
    } else if (PlatformUtil.isMacOS) {
      textSelectionControls = cupertinoDesktopTextSelectionHandleControls;
    } else {
      textSelectionControls = desktopTextSelectionHandleControls;
    }
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    // final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    // if (willShowSelectionHandles != _showSelectionHandles) {
    //   setState(() {
    //     _showSelectionHandles = willShowSelectionHandles;
    //   });
    // }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText.bringIntoView(selection.extent);
        }
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText.hideToolbar();
        }
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (controller.selection.isCollapsed) {
      _editableText.toggleToolbar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onTap: () {
        _editableText.requestKeyboard();
      },
      onFocus: () {
        if (focusNode.canRequestFocus && !focusNode.hasFocus) {
          focusNode.requestFocus();
        } else {
          // If the platform requested focus, that means that previously the
          // platform believed that the text field did not have focus (even
          // though Flutter's widget system believed otherwise). This likely
          // means that the on-screen keyboard is hidden, or more generally,
          // there is no current editing session in this field. To correct
          // that, keyboard must be requested.
          //
          // A concrete scenario where this can happen is when the user
          // dismisses the keyboard on the web. The editing session is
          // closed by the engine, but the text field widget stays focused
          // in the framework.
          _editableText.requestKeyboard();
        }
      },
      child: _selectionGestureDetectorBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.elTheme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: EditableText(
              key: editableTextKey,
              controller: controller,
              focusNode: focusNode,
              cursorColor: context.elTheme.primary,
              backgroundCursorColor: Colors.red,
              style: ElDefaultTextStyle.of(context).style,
              maxLines: null,
              expands: true,
              showSelectionHandles: true,
              // showSelectionHandles: true,
              selectionColor: focusNode.hasFocus
                  ? context.elTheme.primary.elLight5(context)
                  : null,
              selectionControls: textSelectionControls,
              onSelectionChanged: _handleSelectionChanged,
              onSelectionHandleTapped: _handleSelectionHandleTapped,
              magnifierConfiguration: widget.enabledMagnifier
                  ? TextMagnifier.adaptiveMagnifierConfiguration
                  : TextMagnifierConfiguration.disabled,
            ),
          ),
        ),
      ),
    );
  }
}

class _TextFieldSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({required ElEditorState state})
      : _state = state,
        super(delegate: state);

  final ElEditorState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {}

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onTapAlwaysCalled;

  @override
  void onUserTap() {
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}
