# KeyNest Flutter Mobile UI Overview Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a runnable Flutter high-fidelity UI gallery covering all thirteen approved KeyNest mobile screens.

**Architecture:** Create `apps/mobile` as a Material 3 Flutter app with GoRouter. A gallery route selects product pages and simulated device width; product pages compose shared widgets and immutable synthetic fixtures, while ephemeral reveal and feedback state remains local.

**Tech Stack:** Flutter, Dart, Material 3, GoRouter, flutter_test, Lucide Icons Flutter.

---

### Task 1: Scaffold and Route the Mobile App

**Files:**
- Create: `apps/mobile/pubspec.yaml`
- Create: `apps/mobile/analysis_options.yaml`
- Create: `apps/mobile/lib/main.dart`
- Create: `apps/mobile/lib/app/app.dart`
- Create: `apps/mobile/lib/app/router.dart`
- Test: `apps/mobile/test/app/app_test.dart`

- [ ] **Step 1: Write a failing smoke test**

```dart
testWidgets('shows the KeyNest gallery', (tester) async {
  await tester.pumpWidget(const KeyNestApp());
  expect(find.text('KeyNest 界面概览'), findsOneWidget);
});
```

- [ ] **Step 2: Run `flutter test test/app/app_test.dart` in `apps/mobile`**

Expected: FAIL because `KeyNestApp` does not exist.

- [ ] **Step 3: Create the Material app and `/overview` route**

`main.dart` calls `runApp(const KeyNestApp())`; `KeyNestApp` uses `MaterialApp.router`, Chinese locale, Material 3, and the router from `app/router.dart`.

- [ ] **Step 4: Run `flutter analyze && flutter test`**

Expected: both exit 0.

- [ ] **Step 5: Commit**

```bash
git add apps/mobile
git commit -m "build(mobile): scaffold Flutter UI overview"
```

### Task 2: Theme, Fixtures, and Shared Widgets

**Files:**
- Create: `apps/mobile/lib/app/keynest_theme.dart`
- Create: `apps/mobile/lib/demo/demo_data.dart`
- Create: `apps/mobile/lib/shared/widgets/brand_logo.dart`
- Create: `apps/mobile/lib/shared/widgets/sensitive_field.dart`
- Create: `apps/mobile/lib/shared/widgets/vault_list_tile.dart`
- Create: `apps/mobile/lib/shared/widgets/sync_status.dart`
- Test: `apps/mobile/test/shared/sensitive_field_test.dart`

- [ ] **Step 1: Write the failing reveal test**

```dart
testWidgets('secret is hidden until explicitly revealed', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SensitiveField(label: 'API Key', value: 'sk-public-example'))));
  expect(find.text('sk-public-example'), findsNothing);
  await tester.tap(find.bySemanticsLabel('显示 API Key'));
  await tester.pump();
  expect(find.text('sk-public-example'), findsOneWidget);
});
```

- [ ] **Step 2: Run the focused test and confirm failure**

- [ ] **Step 3: Implement the approved tokens and widgets**

Define colors, radii, typography, 44px minimum targets and light borders in `KeyNestTheme`. Fixtures contain GitHub, OpenAI, Google and the approved device examples. Sensitive values use monospace and local reveal state only.

- [ ] **Step 4: Run `flutter analyze && flutter test test/shared/sensitive_field_test.dart`**

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add apps/mobile/lib apps/mobile/test
git commit -m "feat(mobile): add KeyNest theme and shared widgets"
```

### Task 3: Gallery and Navigation Shell

**Files:**
- Create: `apps/mobile/lib/gallery/overview_page.dart`
- Create: `apps/mobile/lib/gallery/device_frame.dart`
- Create: `apps/mobile/lib/shared/widgets/app_bottom_navigation.dart`
- Test: `apps/mobile/test/gallery/overview_page_test.dart`

- [ ] **Step 1: Write a failing page-selection test**

Select `首页`, assert the device frame contains `下午好` and does not contain `KeyNest 界面概览` inside its product subtree.

- [ ] **Step 2: Run the test and confirm failure**

- [ ] **Step 3: Implement selection for 360px, 390px, and 430px frames**

The gallery controls remain outside `DeviceFrame`. Product pages receive no gallery state. Bottom navigation exposes exactly `首页`, `密码库`, `生成器`, and `设置`.

- [ ] **Step 4: Run the gallery test and analyzer**

- [ ] **Step 5: Commit**

```bash
git add apps/mobile/lib/gallery apps/mobile/lib/shared apps/mobile/test/gallery
git commit -m "feat(mobile): add device gallery and navigation shell"
```

### Task 4: Authentication and Vault Lifecycle Screens

**Files:**
- Create: `apps/mobile/lib/features/auth/login_page.dart`
- Create: `apps/mobile/lib/features/unlock/create_vault_page.dart`
- Create: `apps/mobile/lib/features/unlock/recovery_key_page.dart`
- Create: `apps/mobile/lib/features/unlock/unlock_page.dart`
- Test: `apps/mobile/test/features/unlock/create_vault_page_test.dart`

- [ ] **Step 1: Write failing validation tests**

Assert mismatched master passwords show `两次输入的主密码不一致`, a weak password exposes its strength, and recovery confirmation is disabled until the user explicitly checks `我已安全保存`.

- [ ] **Step 2: Run the focused tests and confirm failure**

- [ ] **Step 3: Implement the four screens**

Keep the login and unlock screens centered and borderless. The recovery key uses one serious but restrained bordered panel; biometric actions are visually secondary.

- [ ] **Step 4: Run analyzer and tests**

- [ ] **Step 5: Commit**

```bash
git add apps/mobile/lib/features/auth apps/mobile/lib/features/unlock apps/mobile/test/features
git commit -m "feat(mobile): add authentication and vault lifecycle previews"
```

### Task 5: Daily Vault Screens

**Files:**
- Create: `apps/mobile/lib/features/home/home_page.dart`
- Create: `apps/mobile/lib/features/vault/vault_page.dart`
- Create: `apps/mobile/lib/features/item/login_detail_page.dart`
- Create: `apps/mobile/lib/features/item/api_key_detail_page.dart`
- Create: `apps/mobile/lib/features/item/new_item_sheet.dart`
- Create: `apps/mobile/lib/features/search/search_page.dart`
- Test: `apps/mobile/test/features/search/search_page_test.dart`

- [ ] **Step 1: Write a failing local-search UI test**

Enter `Git` and assert GitHub appears while OpenAI does not; clear the query and assert all synthetic items reappear.

- [ ] **Step 2: Run the focused test and confirm failure**

- [ ] **Step 3: Implement the six screens**

Home contains greeting, search, four quick entries, recent items and favorites. Vault uses 56–72px rows and type filters. Details reset secret visibility on disposal. New item uses a 24px top-radius bottom sheet and type-specific fields.

- [ ] **Step 4: Run analyzer and all tests**

- [ ] **Step 5: Commit**

```bash
git add apps/mobile/lib/features apps/mobile/test/features
git commit -m "feat(mobile): add vault and search preview screens"
```

### Task 6: Generator, Settings, Devices, and Feedback

**Files:**
- Create: `apps/mobile/lib/features/generator/generator_page.dart`
- Create: `apps/mobile/lib/features/settings/settings_page.dart`
- Create: `apps/mobile/lib/features/devices/devices_page.dart`
- Test: `apps/mobile/test/features/devices/devices_page_test.dart`

- [ ] **Step 1: Write a failing revoke-flow test**

Tap `撤销访问`, assert the confirmation dialog appears, cancel once, then confirm and assert the device row displays `已撤销`.

- [ ] **Step 2: Run the focused test and confirm failure**

- [ ] **Step 3: Implement the three screens and restrained feedback**

Generator includes length, five switches, strength, copy/refresh and `使用此密码`. Settings uses approved groups. Devices marks the current device and protects destructive actions with confirmation. Use SnackBar for `已复制`, `已保存`, `已删除`, and `同步完成`.

- [ ] **Step 4: Run `flutter analyze && flutter test`**

Expected: all checks pass.

- [ ] **Step 5: Commit**

```bash
git add apps/mobile
git commit -m "feat(mobile): complete mobile UI overview screens"
```

### Task 7: Multi-Width and Accessibility Verification

**Files:**
- Create: `apps/mobile/test/gallery/responsive_gallery_test.dart`
- Modify: only files identified by failing overflow or semantics assertions

- [ ] **Step 1: Add width and semantics checks**

Pump every page at logical widths 360, 390, and 430; assert `tester.takeException()` is null, all primary actions are at least 44×44, and sensitive controls have Chinese semantic labels.

- [ ] **Step 2: Run `flutter test test/gallery/responsive_gallery_test.dart`**

Expected: failures identify any overflow, undersized target or missing label.

- [ ] **Step 3: Apply only fixes proven necessary by the failing checks**

- [ ] **Step 4: Run `dart format --set-exit-if-changed lib test && flutter analyze && flutter test`**

Expected: formatter reports no changes, analyzer reports no issues, and all tests pass. Run the gallery and capture 360px, 390px, and 430px screenshots for final visual inspection.

- [ ] **Step 5: Commit**

```bash
git add apps/mobile
git commit -m "test(mobile): verify responsive accessible UI overview"
```

