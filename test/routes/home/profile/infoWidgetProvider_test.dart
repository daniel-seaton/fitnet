import 'package:fitnet/routes/home/profile/infoScreenSelector/userInfo/userInfo.dart';
import 'package:fitnet/routes/home/profile/infoScreenSelector/userStats/userStats.dart';
import 'package:fitnet/routes/home/profile/infoWidgetProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers.dart';

void main() {
  initTests();

  group('Unit Tests', () {
    group('select', () {
      test('should set selected widget to userInfo if key == 0', () {
        InfoWidgetProvider provider = InfoWidgetProvider();
        provider.selectedWidget = Container();
        provider.select(0);
        expect(provider.selectedWidget.runtimeType, UserInfo);
      });

      test('should set selected widget to userInfo if key == 1', () {
        InfoWidgetProvider provider = InfoWidgetProvider();
        provider.selectedWidget = Container();
        provider.select(1);
        expect(provider.selectedWidget.runtimeType, UserStats);
      });

      test('should not change selected widget to userInfo if key != 0 or 1',
          () {
        InfoWidgetProvider provider = InfoWidgetProvider();
        provider.selectedWidget = Container();
        provider.select(2);
        expect(provider.selectedWidget.runtimeType, Container);
      });
    });

    group('userInfoSelected', () {
      test('should return true if selectedWidget type is userInfo', () {
        InfoWidgetProvider provider = InfoWidgetProvider();
        provider.selectedWidget = UserInfo();
        expect(provider.userInfoSelected(), true);
      });

      test('should return false if selectedWidget type is not userInfo', () {
        InfoWidgetProvider provider = InfoWidgetProvider();
        provider.selectedWidget = Container();
        expect(provider.userInfoSelected(), false);
      });
    });
  });

  group('Component Tests', () {
    // Nothing to component test
  });
}
