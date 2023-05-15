import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(LinkifyExample());

class LinkifyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_linkify example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('flutter_linkify example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Linkify(
                    onOpen: _onOpen,
                    text:
                        "Made by https://cretezy.com\n\nMail: example@gmail.com",
                  ),
                  SizedBox(height: 64),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    text:
                        "Made by https://cretezy.com\n\nMail: example@gmail.com",
                  ),
                  SizedBox(height: 64),
                  Linkify(
                    onOpen: print,
                    text: "@Cretezy +123456789",
                    linkifiers: [
                      const UserTagLinkifier(),
                      const PhoneNumberLinkifier(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }
}
