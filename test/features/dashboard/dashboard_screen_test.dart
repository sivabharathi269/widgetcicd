import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgethub/features/dashboard/dashboard_screen.dart';

void main() {
  testWidgets('DashboardScreen builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: const DashboardScreen(),
        ),
      ),
    );

    // Verify the app bar title
    expect(find.text('Dashboard'), findsOneWidget);

    // Verify the cards are present
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('FAQ'), findsOneWidget);
    expect(find.text('API Demo'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verify icons are present
    expect(find.byIcon(Icons.check_box), findsOneWidget);
    expect(find.byIcon(Icons.question_answer), findsOneWidget);
    expect(find.byIcon(Icons.api), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('DashboardScreen has GridView with 4 children', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: const DashboardScreen(),
        ),
      ),
    );

    // Verify GridView has 4 children
    final gridViewFinder = find.byType(GridView);
    expect(gridViewFinder, findsOneWidget);

    final GridView gridView = tester.widget<GridView>(gridViewFinder);
    expect(gridView.childrenDelegate.estimatedChildCount, 4);
  });
}
