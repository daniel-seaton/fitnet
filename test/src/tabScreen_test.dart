import 'package:fitnet/src/tabScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void main() {
  initTests();

  group('Unit Tests', () {
    // nothing to unit test here
  });

  group('Component Tests', () {
    testWidgets('should have upper tab if added', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(TabScreen(
        upperTabs: [Tab(child: Text('Upper'))],
        tabPages: [TestWidget()],
      )));

      expect(find.widgetWithText(Tab, 'Upper'), findsOneWidget);
    });

    testWidgets('should have lower tab if added', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(TabScreen(
          lowerTabs: [Tab(child: Text('Lower'))], tabPages: [TestWidget()])));

      expect(find.widgetWithText(Tab, 'Lower'), findsOneWidget);
    });

    testWidgets('should have tabPage if added', (WidgetTester tester) async {
      await tester.pumpWidget(
          createWidgetForTesting(TabScreen(tabPages: [TestWidget()])));

      expect(find.byType(TestWidget), findsOneWidget);
    });
  });
}
