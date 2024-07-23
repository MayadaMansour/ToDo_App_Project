import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/app_config_provider.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "Splash_Screen";

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: provider.isDark()
          ? const Image(
              image: AssetImage(
                "assets/images/splash_dark.png",
              ),
              fit: BoxFit.fill,
            )
          : const Image(
              image: AssetImage(
                "assets/images/splash_light.png",
              ),
              fit: BoxFit.fill,
            ),
    );
  }
}
