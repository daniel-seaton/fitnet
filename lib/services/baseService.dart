

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../serviceInjector.dart';

mixin BaseService {
  final SharedPreferences local = injector<SharedPreferences>();
  final String authority = 'teg05gabc4.execute-api.us-east-1.amazonaws.com';
  final String basePath = 'dev';

  Map<String, String> get headers => {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application.json',
    HttpHeaders.authorizationHeader:  'Bearer ${local.getString('jwt')}'
  };
}