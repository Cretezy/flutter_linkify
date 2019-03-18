import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/linkify.dart';

export 'package:flutter_linkify/linkify.dart'
    show
        LinkifyElement,
        LinkableElement,
        LinkElement,
        EmailElement,
        TextElement,
        LinkType;

/// Callback clicked link
typedef LinkCallback(LinkableElement link);

/// Turns URLs into links
class Linkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Enables some types of links (URL, email).
  /// Will default to all (if `null`).
  final List<LinkType> linkTypes;

  /// Style for non-link text
  final TextStyle style;

  /// Style of link text
  final TextStyle linkStyle;

  /// Callback for tapping a link
  final LinkCallback onOpen;

  /// Text direction of the text
  final TextDirection textDirection;

  /// Removes http/https from shown URLS.
  /// Will default to `false` (if `null`)
  final bool humanize;

  const Linkify({
    Key key,
    this.text,
    this.style,
    this.linkStyle,
    this.textDirection,
    this.humanize,
    this.onOpen,
    this.linkTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      textDirection: textDirection,
      text: buildTextSpan(
        text: text,
        style: Theme.of(context).textTheme.body1.merge(style),
        linkStyle: Theme.of(context)
            .textTheme
            .body1
            .merge(style)
            .copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyle),
        onOpen: onOpen,
        humanize: humanize,
        linkTypes: linkTypes,
      ),
    );
  }
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan({
  String text,
  TextStyle style,
  TextStyle linkStyle,
  LinkCallback onOpen,
  bool humanize,
  List<LinkType> linkTypes,
}) {
  void _onOpen(LinkableElement element) {
    if (onOpen != null) {
      onOpen(element);
    }
  }

  final elements = linkify(
    text,
    humanize: humanize,
    linkTypes: linkTypes,
  );

  return TextSpan(
    children: elements.map<TextSpan>(
      (element) {
        if (element is LinkableElement) {
          return TextSpan(
            text: element.text,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = () => _onOpen(element),
          );
        } else {
          return TextSpan(
            text: element.text,
            style: style,
          );
        }
      },
    ).toList(),
  );
}
