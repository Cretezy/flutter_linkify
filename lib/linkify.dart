abstract class LinkifyElement {}

class LinkElement extends LinkifyElement {
  final String url;

  LinkElement(this.url);

  @override
  String toString() {
    return "LinkElement: $url";
  }
}

class TextElement extends LinkifyElement {
  final String text;

  TextElement(this.text);

  @override
  String toString() {
    return "TextElement: $text";
  }
}

final _linkifyRegex =
    RegExp(r"(.*?)((?:https?):\/\/[^\s/$.?#].[^\s]*)", caseSensitive: false);

List<LinkifyElement> linkifiy(String text) {
  final list = List<LinkifyElement>();

  final match = _linkifyRegex.firstMatch(text);
  if (match == null) {
    if (text.isNotEmpty) {
      list.add(TextElement(text));
    }
  } else {
    text = text.replaceFirst(_linkifyRegex, "");

    if (match.group(1).isNotEmpty) {
      list.add(TextElement(match.group(1)));
    }

    if (match.group(2).isNotEmpty) {
      list.add(LinkElement(match.group(2)));
    }

    list.addAll(linkifiy(text));
  }

  return list;
}
