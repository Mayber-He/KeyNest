import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/gallery/overview_page.dart';

void main() {
  testWidgets('selecting 首页 shows the home product page in the device frame',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OverviewPage(),
      ),
    );

    final homeDestination = find.text('首页');
    await tester.ensureVisible(homeDestination);
    await tester.tap(homeDestination);
    await tester.pump();

    final productFrame = find.byKey(const Key('product-frame'));
    expect(find.descendant(of: productFrame, matching: find.text('下午好')),
        findsOneWidget);
    expect(
      find.descendant(of: productFrame, matching: find.text('KeyNest 界面概览')),
      findsNothing,
    );
  });
}
