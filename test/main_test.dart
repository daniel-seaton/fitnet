import 'package:fitnet/serviceInjector.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';
import 'mocks.dart';

void main() {
  initTests();

  MockAuthService serviceMock = injector<AuthService>();

  group('Unit Tests', () {
    // No unit tests needed
  });

  group('Component Tests', () {
    // No component tests needed
  });
}
