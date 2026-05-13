import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:crud_flutter_app/main.dart';
import 'package:crud_flutter_app/providers/photo_provider.dart';

void main() {

  testWidgets('App loads and displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PhotoProvider(),
        child: MyApp(),
      ),
    );

    // Verify AppBar title
    expect(find.text('Photo Manager'), findsOneWidget);
  });

  testWidgets('Floating Action Button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PhotoProvider(),
        child: MyApp(),
      ),
    );

    // Verify FAB exists
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Shows loading indicator initially', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PhotoProvider(),
        child: MyApp(),
      ),
    );

    // Trigger frame
    await tester.pump();

    // Check loading indicator (may appear briefly)
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

}