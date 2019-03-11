import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new LinkifyExample());

class LinkifyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'flutter_linkify example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('flutter_linkify example'),
        ),
        body: Center(
          child: Linkify(
            onOpen: (url) async {
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            text: "Made by https://cretezy.com\n\nMail: mailto:charles@cretezy.com",
          ),
        ),
      ),
    );
  }
}
