import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/demo/demo_data.dart';
import 'package:keynest_mobile/features/auth/login_page.dart';
import 'package:keynest_mobile/features/devices/devices_page.dart';
import 'package:keynest_mobile/features/generator/generator_page.dart';
import 'package:keynest_mobile/features/home/home_page.dart';
import 'package:keynest_mobile/features/item/api_key_detail_page.dart';
import 'package:keynest_mobile/features/item/login_detail_page.dart';
import 'package:keynest_mobile/features/search/search_page.dart';
import 'package:keynest_mobile/features/settings/settings_page.dart';
import 'package:keynest_mobile/features/unlock/create_vault_page.dart';
import 'package:keynest_mobile/features/unlock/recovery_key_page.dart';
import 'package:keynest_mobile/features/unlock/unlock_page.dart';
import 'package:keynest_mobile/features/vault/vault_page.dart';
import 'package:keynest_mobile/gallery/overview_page.dart';

void main() {
  testWidgets('renders the gallery pages at supported widths', (tester) async {
    final pages = <Widget>[
      const OverviewPage(),
      const LoginPage(),
      const CreateVaultPage(),
      const RecoveryKeyPage(),
      const UnlockPage(),
      const HomePage(),
      const VaultPage(),
      const SearchPage(),
      LoginDetailPage(item: demoVaultItems[0]),
      ApiKeyDetailPage(item: demoVaultItems[1]),
      const GeneratorPage(),
      const SettingsPage(),
      const DevicesPage(),
    ];

    for (final width in [360.0, 390.0, 430.0]) {
      tester.view.physicalSize = Size(width, 800);
      tester.view.devicePixelRatio = 1;
      for (final page in pages) {
        await tester.pumpWidget(MaterialApp(home: page));
        await tester.pump();
        expect(tester.takeException(), isNull,
            reason: 'page overflowed at $width pixels');
      }
    }

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('sensitive controls expose Chinese semantics', (tester) async {
    await tester.pumpWidget(
        MaterialApp(home: ApiKeyDetailPage(item: demoVaultItems[1])));

    expect(find.bySemanticsLabel('显示 API Key'), findsOneWidget);
  });
}
