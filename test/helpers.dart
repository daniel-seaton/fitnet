import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testServiceInjector.dart';

typedef Callback(MethodCall call);

void initTests() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  Firebase.initializeApp();
  setupTestServiceInjector();
}

Widget createWidgetForTesting(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

setupFirebaseAuthMocks([Callback customHandlers]) {
  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}
