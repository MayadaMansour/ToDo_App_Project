import 'package:flutter/material.dart';
import 'package:todo_app_project/ui/board/board_screen.dart';
import 'package:todo_app_project/utils/theme/theme.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightMode,
      // darkTheme: MyThemeData.darkMode,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
