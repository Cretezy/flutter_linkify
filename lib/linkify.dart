abstract class LinkifyElement {}

/// Represents an element containing a link
class LinkElement extends LinkifyElement {
  final String url;
  final String text;

  LinkElement(this.url, [String text]) : this.text = text ?? url;

  @override
  String toString() {
    return "LinkElement: $url ($text)";
  }
}

/// Represents an element containing text
class TextElement extends LinkifyElement {
  final String text;

  TextElement(this.text);

  @override
  String toString() {
    return "TextElement: $text";
  }
}

final _linkifyUrlRegex = RegExp(
  r"(\n*?.*?\s*?)((?:https?):\/\/[^\s/$.?#].[^\s]*)",
  caseSensitive: false,
);

final _linkifyEmailRegex = RegExp(
  r"(\n*?.*?\s*?)((mailto:)[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})",
  caseSensitive: false
);

/// Turns [text] into a list of [LinkifyElement]
///
/// Use [humanize] to remove http/https from the start of the URL shown.
List<LinkifyElement> linkify(String text, {bool humanize = false}) {
  final list = List<LinkifyElement>();

  if (text == null || text.isEmpty) {
    return list;
  }

  final urlMatch = _linkifyUrlRegex.firstMatch(text);
  final emailMatch = _linkifyEmailRegex.firstMatch(text);
  if (urlMatch == null && emailMatch == null) {
    list.add(TextElement(text));
  } else if (urlMatch != null){
    text = text.replaceFirst(_linkifyUrlRegex, "");

    if (urlMatch.group(1).isNotEmpty) {
      list.add(TextElement(urlMatch.group(1)));
    }

    if (urlMatch.group(2).isNotEmpty) {
      if (humanize ?? false) {
        print("humanizing url ${urlMatch.group(2)}");
        list.add(LinkElement(
          urlMatch.group(2),
          urlMatch.group(2).replaceFirst(RegExp(r"https?://"), ""),
        ));
      } else {
        print("not humanizing url ${urlMatch.group(2)}");
        list.add(LinkElement(urlMatch.group(2)));
      }
    }

    list.addAll(linkify(text, humanize: humanize));
  } else if (emailMatch != null) {
    text = text.replaceFirst(_linkifyEmailRegex, "");

    if (emailMatch.group(1).isNotEmpty) {
      list.add(TextElement(emailMatch.group(1)));
    }

    if (emailMatch.group(2).isNotEmpty) {
      // Always humanize emails
      print("humanizing email ${emailMatch.group(2)}");
      list.add(LinkElement(
        emailMatch.group(2),
        emailMatch.group(2).replaceFirst(RegExp(r"mailto:"), ""),
      ));
    }

    list.addAll(linkify(text, humanize: humanize));
  }

  return list;
}
