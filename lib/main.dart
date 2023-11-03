import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/home-screen.dart';
import 'package:news/News/NewsContent.dart';
import 'package:news/Provider/app_config_provider.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:news/category/category_details.dart';
import 'package:news/category/category_items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => appConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var provider = Provider.of<appConfigProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      initialRoute: homeScreen.routeName,
      routes: {
        NewsContent.routeName: (context) => NewsContent(),
        homeScreen.routeName: (context) => homeScreen(),
        // categoryDetails.routeName : (context)=>categoryDetails(),
      },
      theme: myTheme.lightTheme,
    );
  }
}
