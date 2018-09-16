# `flutter_linkify` [![pub package](https://img.shields.io/pub/v/flutter_linkify.svg)](https://pub.dartlang.org/packages/flutter_linkify)

Turns text URLs into clickable inline links in text for Flutter.

[Pub](https://pub.dartlang.org/packages/flutter_linkify) - [API Docs](https://pub.dartlang.org/documentation/flutter_linkify/latest/) - [GitHub](https://github.com/Cretezy/flutter_linkify)

## Install

Install by adding this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_linkify: 1.0.1
```

It is highly recommend that you also add a dependency on [`url_launcher`](https://pub.dartlang.org/packages/url_launcher) to open links in the browser.

## Usage

Basic:
```dart
import 'package:flutter_linkify/flutter_linkify.dart';

Linkify(
  onOpen: (url) => print("Clicked $url!"),
  text: "Made by https://cretezy.com",
);
```

Add a style to non-links (yellow) or links (red), and open in browser using [`url_launcher`](https://pub.dartlang.org/packages/url_launcher):
```dart
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

Linkify(
  onOpen: (url) async {
    if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
  },
  text: "Made by https://cretezy.com",
  style: TextStyle(color: Colors.yellow),
  linkStyle: TextStyle(color: Colors.red),
);
```

Full example can be found at [`example/lib/main.dart`](example/lib/main.dart).

![Example Screenshot](https://github.com/Cretezy/flutter_linkify/raw/master/example/screenshot.png)
