import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/features/unlock/create_vault_page.dart';
import 'package:keynest_mobile/features/unlock/recovery_key_page.dart';

void main() {
  testWidgets('shows a mismatch error for different master passwords',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CreateVaultPage()));

    await tester.enterText(find.bySemanticsLabel('主密码'), 'strong-password');
    await tester.enterText(
        find.bySemanticsLabel('确认主密码'), 'different-password');
    await tester.pump();

    expect(find.text('两次输入的主密码不一致'), findsOneWidget);
  });

  testWidgets('shows weak password strength', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CreateVaultPage()));

    await tester.enterText(find.bySemanticsLabel('主密码'), '123');
    await tester.pump();

    expect(find.text('密码强度：弱'), findsOneWidget);
  });

  testWidgets('requires recovery confirmation before continuing',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RecoveryKeyPage()));

    final button =
        tester.widget<FilledButton>(find.widgetWithText(FilledButton, '确认已保存'));
    expect(button.onPressed, isNull);

    await tester.tap(find.text('我已安全保存'));
    await tester.pump();

    final enabledButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, '确认已保存'),
    );
    expect(enabledButton.onPressed, isNotNull);
  });
}
