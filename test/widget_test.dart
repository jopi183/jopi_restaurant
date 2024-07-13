// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jopi_restaurant/main.dart';
import 'package:jopi_restaurant/ui/dashboardpage.dart';
import 'package:jopi_restaurant/ui/loginpage.dart';
void main() {
  testWidgets('Dashboard Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(DashboardPage), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(DashboardPage), findsWidgets);
  });

  testWidgets('Login Page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LoginPage(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
