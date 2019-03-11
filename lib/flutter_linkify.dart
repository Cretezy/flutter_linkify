import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/linkify.dart';

/// Callback with URL to open
typedef LinkCallback(String url);

/// Callback with Email address
typedef EmailCallback(String emailAddress);

/// Turns URLs into links
class Linkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Style for non-link text
  final TextStyle style;

  /// Style of link text
  final TextStyle linkStyle;

  /// Callback for tapping a link
  final LinkCallback onLinkOpen;

  /// Callback for tapping an email
  final EmailCallback onEmailOpen;

  /// Text direction of the text
  final TextDirection textDirection;

  /// Removes http/https from shown URLS
  final bool humanize;

  const Linkify({
    Key key,
    this.text,
    this.style,
    this.linkStyle,
    this.onLinkOpen,
    this.onEmailOpen,
    this.textDirection,
    this.humanize = false,
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
        onLinkOpen: onLinkOpen,
        onEmailOpen: onEmailOpen,
        humanize: humanize,
      ),
    );
  }
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan({
  String text,
  TextStyle style,
  TextStyle linkStyle,
  LinkCallback onLinkOpen,
  EmailCallback onEmailOpen,
  bool humanize = false,
}) {
  void _onLinkOpen(String url) {
    if (onLinkOpen != null) {
      onLinkOpen(url);
    }
  }

  void _onEmailOpen(String emailAddress) {
    if (onEmailOpen != null) {
      onEmailOpen(emailAddress);  // TODO: discussable; add "mailto:" here for immediate use with url_launcher or except developers to do it themselves
    }
  }

  final elements = linkify(
    text,
    humanize: humanize,
  );

  return TextSpan(
    children: elements.map<TextSpan>(
      (element) {
        if (element is TextElement) {
          return TextSpan(
            text: element.text,
            style: style,
          );
        } else if (element is LinkElement) {
          return TextSpan(
            text: element.text,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => _onLinkOpen(element.url),
          );
        } else if (element is EmailElement) {
          return TextSpan(
              text: element.text,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
            ..onTap = () => _onEmailOpen(element.emailAddress),
          );
        }
      },
    ).toList(),
  );
}
