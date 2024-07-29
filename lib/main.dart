import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/core/provider/task_list_provider.dart';
import 'package:todo_app_project/ui/board/board_screen.dart';
import 'package:todo_app_project/utils/theme/theme.dart';

import 'core/provider/app_config_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBIBMGaWg-zGCoJ9W1-O_Ev8-HQCJUkn2E",
              appId: "com.example.todo_app_project",
              messagingSenderId: "85975781920",
              projectId: "even-terra-421708"))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TaskListProvider()),
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfigProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: MyThemeData.lightMode,
          themeMode: provider.themeMode,
          darkTheme: MyThemeData.darkMode,
          initialRoute: SplashScreen.routeName,
          locale: Locale(provider.appLanguage),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
