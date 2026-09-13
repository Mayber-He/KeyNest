import 'package:flutter_test/flutter_test.dart';

import 'package:keynest_mobile/app/app.dart';

void main() {
  testWidgets('shows the KeyNest gallery', (tester) async {
    await tester.pumpWidget(const KeyNestApp());

    expect(find.text('KeyNest 界面概览'), findsOneWidget);
  });
}
