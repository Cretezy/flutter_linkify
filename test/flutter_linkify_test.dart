import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SelectableLinkify renders text', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SelectableLinkify(
        text: 'Test https://google.com',
      ),
    ));

    expect(find.text('Test google.com'), findsOneWidget);
  });

  testWidgets('SelectableLinkify renders text without humanizing',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SelectableLinkify(
        text: 'Test https://google.com',
        options: LinkifyOptions(
          humanize: false,
        ),
      ),
    ));

    expect(find.text('Test https://google.com'), findsOneWidget);
  });

  testWidgets('SelectableLinkify renders text with loose URLs', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SelectableLinkify(
        text: 'Test google.com',
        options: LinkifyOptions(
          looseUrl: true,
        ),
      ),
    ));

    expect(find.text('Test google.com'), findsOneWidget);
  });

  testWidgets('SelectableLinkify renders without remove WWW', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SelectableLinkify(
        text: 'Test www.google.com',
      ),
    ));

    expect(find.text('Test www.google.com'), findsOneWidget);
  });

  testWidgets('SelectableLinkify renders with remove WWW', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SelectableLinkify(
        text: 'Test www.google.com',
        options: LinkifyOptions(
          removeWww: true,
        ),
      ),
    ));

    expect(find.text('Test google.com'), findsOneWidget);
  });
}
