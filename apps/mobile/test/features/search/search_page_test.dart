import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/features/search/search_page.dart';

void main() {
  testWidgets('filters synthetic vault items locally and clears the query',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchPage()));

    await tester.enterText(find.bySemanticsLabel('搜索密码库'), 'Git');
    await tester.pump();
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('OpenAI'), findsNothing);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('OpenAI'), findsOneWidget);
  });
}
