
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../services/assets_manager.dart';
import 'onboarding/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AnimatedSplashScreen(
              splash: Image.asset(AssetsManager.splash),
              nextScreen: IntroScreen(),
              splashIconSize: 250,
              splashTransition: SplashTransition.slideTransition ,
            ),
          ),
        ),
      ),
    );
  }
}
