import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';

export 'package:linkify/linkify.dart'
    show
        LinkifyElement,
        LinkifyOptions,
        LinkableElement,
        TextElement,
        Linkifier,
        UrlElement,
        UrlLinkifier,
        EmailElement,
        EmailLinkifier;

/// Callback clicked link
typedef LinkCallback = void Function(LinkableElement link);

/// Turns link to TextStyle
typedef LinkStyleBuilder = TextStyle? Function(LinkableElement link);

/// Turns URLs into links
class Linkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style for non-link text
  final TextStyle? style;

  /// Style of link text
  final LinkStyleBuilder? linkStyleBuilder;

  // Text.rich

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// Text direction of the text
  final TextDirection? textDirection;

  /// The maximum number of lines for the text to span, wrapping if necessary
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel
  final double textScaleFactor;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// The strut style used for the vertical layout
  final StrutStyle? strutStyle;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale
  final Locale? locale;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis textWidthBasis;

  /// Defines how the paragraph will apply TextStyle.height to the ascent of the first line and descent of the last line.
  final TextHeightBehavior? textHeightBehavior;

  final bool useMouseRegion;

  const Linkify({
    Key? key,
    required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options = const LinkifyOptions(),
    // TextSpan
    this.style,
    this.linkStyleBuilder,
    // RichText
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.softWrap = true,
    this.strutStyle,
    this.locale,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.useMouseRegion = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: options,
      linkifiers: linkifiers,
    );

    return Text.rich(
      buildTextSpan(
        elements,
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        onOpen: onOpen,
        useMouseRegion: useMouseRegion,
        linkStyleBuilder: (link) => (style ?? Theme.of(context).textTheme.bodyMedium)
            ?.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyleBuilder?.call(link)),
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      softWrap: softWrap,
      strutStyle: strutStyle,
      locale: locale,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

/// Turns URLs into links
class SelectableLinkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// The number of font pixels for each logical pixel
  final double textScaleFactor;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback? onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style for non-link text
  final TextStyle? style;

  /// Style of link text
  final LinkStyleBuilder? linkStyleBuilder;

  // Text.rich

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Text direction of the text
  final TextDirection? textDirection;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int? minLines;

  /// The maximum number of lines for the text to span, wrapping if necessary
  final int? maxLines;

  /// The strut style used for the vertical layout
  final StrutStyle? strutStyle;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis? textWidthBasis;

  // SelectableText.rich

  /// Defines the focus for this widget.
  final FocusNode? focusNode;

  /// Whether to show cursor
  final bool showCursor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Builds the text selection toolbar when requested by the user
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// How thick the cursor will be
  final double cursorWidth;

  /// How rounded the corners of the cursor should be
  final Radius? cursorRadius;

  /// The color to use when painting the cursor
  final Color? cursorColor;

  /// Determines the way that drag start behavior is handled
  final DragStartBehavior dragStartBehavior;

  /// If true, then long-pressing this TextField will select text and show the cut/copy/paste menu,
  /// and tapping will move the text caret
  final bool enableInteractiveSelection;

  /// Called when the user taps on this selectable text (not link)
  final GestureTapCallback? onTap;

  final ScrollPhysics? scrollPhysics;

  /// Defines how the paragraph will apply TextStyle.height to the ascent of the first line and descent of the last line.
  final TextHeightBehavior? textHeightBehavior;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// Optional delegate for building the text selection handles and toolbar.
  final TextSelectionControls? selectionControls;

  /// Called when the user changes the selection of text (including the cursor location).
  final SelectionChangedCallback? onSelectionChanged;

  final bool useMouseRegion;

  const SelectableLinkify({
    Key? key,
    required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options = const LinkifyOptions(),
    // TextSpan
    this.style,
    this.linkStyleBuilder,
    // RichText
    this.textAlign,
    this.textDirection,
    this.minLines,
    this.maxLines,
    // SelectableText
    this.focusNode,
    this.textScaleFactor = 1.0,
    this.strutStyle,
    this.showCursor = false,
    this.autofocus = false,
    this.contextMenuBuilder,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.scrollPhysics,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.cursorHeight,
    this.selectionControls,
    this.onSelectionChanged,
    this.useMouseRegion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: options,
      linkifiers: linkifiers,
    );

    return SelectableText.rich(
      buildTextSpan(
        elements,
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        onOpen: onOpen,
        linkStyleBuilder:(link) => (style ?? Theme.of(context).textTheme.bodyMedium)
            ?.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyleBuilder?.call(link)),
        useMouseRegion: useMouseRegion,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      strutStyle: strutStyle,
      showCursor: showCursor,
      textScaleFactor: textScaleFactor,
      autofocus: autofocus,
      contextMenuBuilder: contextMenuBuilder,
      cursorWidth: cursorWidth,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: onTap,
      scrollPhysics: scrollPhysics,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      cursorHeight: cursorHeight,
      selectionControls: selectionControls,
      onSelectionChanged: onSelectionChanged,
    );
  }
}

class LinkableSpan extends WidgetSpan {
  LinkableSpan({
    required MouseCursor mouseCursor,
    required InlineSpan inlineSpan,
  }) : super(
          child: MouseRegion(
            cursor: mouseCursor,
            child: Text.rich(
              inlineSpan,
            ),
          ),
        );
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan(
  List<LinkifyElement> elements, {
  TextStyle? style,
  LinkStyleBuilder? linkStyleBuilder,
  LinkCallback? onOpen,
  bool useMouseRegion = false,
}) =>
    TextSpan(
      children: buildTextSpanChildren(
        elements,
        style: style,
        linkStyleBuilder: linkStyleBuilder,
        onOpen: onOpen,
        useMouseRegion: useMouseRegion,
      ),
    );

/// Raw TextSpan builder for more control on the RichText
List<InlineSpan>? buildTextSpanChildren(
  List<LinkifyElement> elements, {
  TextStyle? style,
  LinkStyleBuilder? linkStyleBuilder,
  LinkCallback? onOpen,
  bool useMouseRegion = false,
}) =>
    [
      for (var element in elements)
        if (element is LinkableElement)
          TextSpan(
            text: element.text,
            style: linkStyleBuilder?.call(element),
            recognizer: onOpen != null
                ? (TapGestureRecognizer()..onTap = () => onOpen(element))
                : null,
            mouseCursor: useMouseRegion ? SystemMouseCursors.click : null,
          )
        else
          TextSpan(
            text: element.text,
            style: style,
          ),
    ];

class LinkifySpan extends TextSpan {
  LinkifySpan({
    required String text,
    LinkStyleBuilder? linkStyleBuilder,
    LinkCallback? onOpen,
    LinkifyOptions options = const LinkifyOptions(),
    List<Linkifier> linkifiers = defaultLinkifiers,
    bool useMouseRegion = false,
    super.style,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
  }) : super(
          children: buildTextSpanChildren(
            linkify(text, options: options, linkifiers: linkifiers),
            style: style,
            linkStyleBuilder: linkStyleBuilder,
            onOpen: onOpen,
            useMouseRegion: useMouseRegion,
          ),
        );
}
