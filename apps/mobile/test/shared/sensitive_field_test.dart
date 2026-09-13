import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/shared/widgets/sensitive_field.dart';

void main() {
  testWidgets('secret is hidden until explicitly revealed', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SensitiveField(
            label: 'API Key',
            value: 'sk-public-example',
          ),
        ),
      ),
    );

    expect(find.text('sk-public-example'), findsNothing);
    await tester.tap(find.bySemanticsLabel('显示 API Key'));
    await tester.pump();
    expect(find.text('sk-public-example'), findsOneWidget);
  });
}
