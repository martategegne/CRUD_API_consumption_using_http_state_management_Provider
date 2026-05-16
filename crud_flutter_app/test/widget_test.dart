import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:crud_flutter_app/main.dart';
import 'package:crud_flutter_app/providers/user_provider.dart';

void main() {

  testWidgets('App loads and displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: MyApp(),
      ),
    );

    await tester.pump();

    expect(find.text('User Manager'), findsOneWidget);
  });

  testWidgets('Floating Action Button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: MyApp(),
      ),
    );

    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);
  });

}