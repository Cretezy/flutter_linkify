abstract class LinkifyElement {
  final String text;

  LinkifyElement(this.text);
}

abstract class LinkableElement extends LinkifyElement {
  final String url;

  LinkableElement(String text, this.url) : super(text);
}

enum LinkType { url, email }

/// Represents an element containing a link
class LinkElement extends LinkableElement {
  final String url;

  LinkElement(this.url, [String text]) : super(text ?? url, url);

  @override
  String toString() {
    return "LinkElement: $url ($text)";
  }
}

/// Represents an element containing an email address
class EmailElement extends LinkableElement {
  final String emailAddress;

  EmailElement(this.emailAddress, [String text])
      : super(text ?? emailAddress, "mailto:$emailAddress");

  @override
  String toString() {
    return "EmailElement: $emailAddress ($text)";
  }
}

/// Represents an element containing text
class TextElement extends LinkifyElement {
  TextElement(String text) : super(text);

  @override
  String toString() {
    return "TextElement: $text";
  }
}

final _linkifyUrlRegex = RegExp(
  r"^((?:.|\n)*?)((?:https?):\/\/[^\s/$.?#].[^\s]*)",
  caseSensitive: false,
);

final _linkifyEmailRegex = RegExp(
  r"^((?:.|\n)*?)((mailto:)?[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})",
  caseSensitive: false,
);

/// Turns [text] into a list of [LinkifyElement]
///
/// Use [humanize] to remove http/https from the start of the URL shown.
/// Will default to `false` (if `null`)
///
/// Uses [linkTypes] to enable some types of links (URL, email).
/// Will default to all (if `null`).
List<LinkifyElement> linkify(
  String text, {
  bool humanize,
  List<LinkType> linkTypes,
}) {
  final list = List<LinkifyElement>();

  if (text == null || text.isEmpty) {
    return list;
  }

  if (humanize == null) {
    humanize = false;
  }

  if (linkTypes == null) {
    linkTypes = LinkType.values;
  }

  final urlMatch = linkTypes.contains(LinkType.url)
      ? _linkifyUrlRegex.firstMatch(text)
      : null;
  final emailMatch = linkTypes.contains(LinkType.email)
      ? _linkifyEmailRegex.firstMatch(text)
      : null;

  if (urlMatch == null && emailMatch == null) {
    list.add(TextElement(text));
  } else {
    if (urlMatch != null) {
      text = text.replaceFirst(urlMatch.group(0), "");

      if (urlMatch.group(1).isNotEmpty) {
        list.add(TextElement(urlMatch.group(1)));
      }

      if (urlMatch.group(2).isNotEmpty) {
        if (humanize ?? false) {
          list.add(LinkElement(
            urlMatch.group(2),
            urlMatch.group(2).replaceFirst(RegExp(r"https?://"), ""),
          ));
        } else {
          list.add(LinkElement(urlMatch.group(2)));
        }
      }
    } else if (emailMatch != null) {
      text = text.replaceFirst(emailMatch.group(0), "");

      if (emailMatch.group(1).isNotEmpty) {
        list.add(TextElement(emailMatch.group(1)));
      }

      if (emailMatch.group(2).isNotEmpty) {
        // Always humanize emails
        list.add(EmailElement(
          emailMatch.group(2).replaceFirst(RegExp(r"mailto:"), ""),
        ));
      }
    }

    list.addAll(linkify(
      text,
      humanize: humanize,
      linkTypes: linkTypes,
    ));
  }

  return list;
}
