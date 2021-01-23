import 'package:fitnet/routes/home/profile/infoScreenSelector/selectorButton.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers.dart';

void main() {
  initTests();

  group('Unit Tests', () {
    // Nothing to unit test
  });

  group('Component Tests', () {
    testWidgets('should display label text', (WidgetTester tester) async {
      var labelText = 'asdfghjkl';
      await tester.pumpWidget(createWidgetForTesting(SelectorButton(
        label: labelText,
        selected: false,
        onPressed: () {},
      )));

      expect(find.text(labelText), findsOneWidget);
    });

    testWidgets('should call onPressed when button is clicked',
        (WidgetTester tester) async {
      var labelText = 'asdfghjkl';
      var numInvocations = 0;
      await tester.pumpWidget(createWidgetForTesting(SelectorButton(
        label: labelText,
        selected: true,
        onPressed: () {
          numInvocations++;
        },
      )));

      await tester.tap(find.text(labelText));
      await tester.pump();

      expect(numInvocations, 1);
    });

    // testWidgets('', (WidgetTester tester) async {});
  });
}
