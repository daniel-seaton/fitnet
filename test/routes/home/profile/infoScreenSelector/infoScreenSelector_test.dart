import 'package:fitnet/routes/home/profile/infoScreenSelector/infoScreenSelector.dart';
import 'package:fitnet/routes/home/profile/infoScreenSelector/selectorButton.dart';
import 'package:fitnet/routes/home/profile/infoWidgetProvider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../../../helpers.dart';

void main() {
  initTests();

  group('Unit Tests', () {
    // Nothing to unit test
  });

  group('Component Tests', () {
    testWidgets('should display selectors button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(
          ChangeNotifierProvider<InfoWidgetProvider>.value(
              value: InfoWidgetProvider(), child: InfoScreenSelector())));

      expect(find.byType(SelectorButton), findsNWidgets(2));
    });

    // testWidgets('', (WidgetTester test) async {});
  });
}
