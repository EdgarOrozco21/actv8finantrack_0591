import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:actv8finantrack_0591/main.dart';

void main() {
  testWidgets('FinanTrack app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FinanTrackApp());
    expect(find.text('FinanTrack'), findsOneWidget);
  });
}
