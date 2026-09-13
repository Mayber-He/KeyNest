import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/gallery/overview_page.dart';

void main() {
  testWidgets('bottom navigation renders each real page in the device frame',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OverviewPage(),
      ),
    );

    final productFrame = find.byKey(const Key('product-frame'));

    final destinations = <String, String>{
      '首页': '下午好',
      '密码库': 'GitHub',
      '生成器': '密码强度：强',
      '设置': '保存设置',
    };

    for (final entry in destinations.entries) {
      final destination = find.text(entry.key);
      await tester.ensureVisible(destination);
      await tester.tap(destination);
      await tester.pumpAndSettle();

      expect(
        find.descendant(of: productFrame, matching: find.text(entry.value)),
        findsOneWidget,
        reason: '${entry.key} should render its real page',
      );
    }
  });
}
