import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prod_pin/app.dart';
import 'package:prod_pin/src/config/index.dart' show FlavorConfig, getApiConfig;
import 'package:prod_pin/src/core/index.dart' show initDependencyLocator, getIt;

enum Flavor { staging, prod }

Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await _preInit(flavor);
  await _init(flavor);

  runApp(const App());
}

Future<void> _init(Flavor flavor) async {
  final url = getApiConfig(flavor);
  FlavorConfig(flavor: flavor, baseUrl: url);
}

Future<void> _preInit(Flavor flavor) async {
  initDependencyLocator();
  await getIt.allReady();
}
