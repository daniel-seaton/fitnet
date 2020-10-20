import 'package:fitnet/serviceInjector.dart';
import 'package:fitnet/services/authService.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';
import 'services/authService_test.dart';

void main() {
  initTests();

  AuthService serviceMock;

  setUp(() {
    injector.unregister<AuthService>();
    serviceMock = MockAuthService();
    injector.registerSingleton<AuthService>(serviceMock);
  });
  group('Unit Tests', () {
    // No unit tests needed
  });

  group('Component Tests', () {
    // No component tests needed
  });
}
