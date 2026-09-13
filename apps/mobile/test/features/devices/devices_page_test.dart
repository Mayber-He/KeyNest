import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/features/devices/devices_page.dart';

void main() {
  testWidgets('confirms device revoke before marking it revoked',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DevicesPage()));

    await tester.tap(find.widgetWithText(TextButton, '撤销访问').first);
    await tester.pump();
    expect(find.text('确认撤销设备访问？'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, '取消'));
    await tester.pump();
    expect(find.text('确认撤销设备访问？'), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, '撤销访问').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, '确认撤销'));
    await tester.pump();

    expect(find.text('已撤销'), findsOneWidget);
  });
}
