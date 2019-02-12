abstract class LinkifyElement {}

/// Represents an element containing a link
class LinkElement extends LinkifyElement {
  final String url;

  LinkElement(this.url);

  @override
  String toString() {
    return "LinkElement: $url";
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

final _linkifyRegex = RegExp(r"/(?:(?:https?|ftp|file):\/\/|www\.|ftp\.)(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[-A-Z0-9+&@#\/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[A-Z0-9+&@#\/%=~_|$])/igm",
    caseSensitive: false);

/// Turns [text] into a list of [LinkifyElement]
List<LinkifyElement> linkify(String text) {
  final list = List<LinkifyElement>();

  if (text == null || text.isEmpty) {
    return list;
  }

  final match = _linkifyRegex.firstMatch(text);
  if (match == null) {
    list.add(TextElement(text));
  } else {
    text = text.replaceFirst(_linkifyRegex, "");

    if (match.group(1).isNotEmpty) {
      list.add(TextElement(match.group(1)));
    }

    if (match.group(2).isNotEmpty) {
      list.add(LinkElement(match.group(2)));
    }

    list.addAll(linkify(text));
  }

  return list;
}
