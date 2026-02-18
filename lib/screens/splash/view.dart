import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sellix/screens/splash/components/handle_navigation.dart';
import '../../../core/assets/lottie.dart';
import '../../../core/screen size/screen_size.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return HandleNavigation(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset(
            logoLottie,
            width: width(context) / 2,
            height: height(context) / 1.5,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
