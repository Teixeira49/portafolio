import 'package:flutter/material.dart';

import 'package:portafolio/src/core/providers/providers.dart';
import 'package:portafolio/src/core/theme/app_theme.dart';
import 'package:portafolio/src/core/variables/constants/constants.dart';
import 'package:portafolio/src/features/home/presentation/page/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() async {
 //await dotenv.load();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<AppProvider>(),
      child: Consumer<AppProvider>(
          builder: (context, appProvider, child) {
            return MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme(context),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: appProvider.locale,
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }
      ),);
  }
}
