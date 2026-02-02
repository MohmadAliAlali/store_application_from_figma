import 'package:flutter/material.dart';
import 'dart:async';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/navigation.dart';
import 'package:task_5/core/state_manger.dart';
import 'package:task_5/view/info_set_screen/intro_screen.dart';
import 'package:task_5/view/login_screen/login_screen.dart';
import 'package:task_5/view/nav_pages/nav_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  Future<void> autoLogin() async {
    AppState.init();
    Timer(const Duration(seconds: 4), () {
      if (!AppState.isNotFirstUse) {
        Navigation.navigateAndRemove(context,  const IntroScreens());
      }else if (!AppState.isLoggedIn) {
        Navigation.navigateAndRemove(context,  const LoginScreen());
      }else{
        Navigation.navigateAndRemove(context,  const NavPages());

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.backgroundIntro,
          body: Center(
            child: Image.asset(
              'assets/logo.png',
              width: 320, // Customize the image size
              height: 320,
            ),
          ),
    );
  }
}