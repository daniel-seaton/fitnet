import 'package:fitnet/src/loadingScreen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  initTests();
  group('Unit Tests', () {
    // nothing to unit test in this file
  });

  group('Component Tests', () {
    testWidgets('title should be Fitnet', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(LoadingScreen()));

      expect(find.text('Fitnet'), findsOneWidget);
    });

    testWidgets('body should say loading', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(LoadingScreen()));

      expect(find.text('Loading'), findsOneWidget);
    });
  });
}
