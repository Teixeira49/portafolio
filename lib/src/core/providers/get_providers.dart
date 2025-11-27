import 'dart:ui';

import 'package:get_it/get_it.dart';

import 'app_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {

  // Registra el AppProvider como un Singleton
  getIt.registerSingleton<AppProvider>(AppProvider(null));
  // ...
}
