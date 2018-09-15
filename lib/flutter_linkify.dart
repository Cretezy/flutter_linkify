import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/linkify.dart';

/// Callback with URL to open
typedef LinkCallback(String url);

/// Turns URLs into links
class Linkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Style for non-link text
  final TextStyle style;

  /// Style of link text
  final TextStyle linkStyle;

  /// Callback for tapping a link
  final LinkCallback onOpen;

  const Linkify({
    Key key,
    this.text,
    this.style,
    this.linkStyle,
    this.onOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
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
      ),
    );
  }
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan(
    {String text, TextStyle style, TextStyle linkStyle, LinkCallback onOpen}) {
  void _onOpen(String url) {
    if (onOpen != null) {
      onOpen(url);
    }
  }

  final elements = linkify(text);

  return TextSpan(
      children: elements.map<TextSpan>((element) {
    if (element is TextElement) {
      return TextSpan(
        text: element.text,
        style: style,
      );
    } else if (element is LinkElement) {
      return TextSpan(
        text: element.url,
        style: linkStyle,
        recognizer: TapGestureRecognizer()..onTap = () => _onOpen(element.url),
      );
    }
  }).toList());
}
