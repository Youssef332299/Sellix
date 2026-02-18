import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellix/core/colors/app_colors.dart';
import '../constants/constants.dart';
import '../screen size/screen_size.dart';

class Background extends StatelessWidget {
  Background({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary800,
      body: Container(
        height: height(context),
        width: width(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.backgroundGradientStart, // كحلي غامق جدًا
              AppColors.backgroundGradientEnd, // أزرق غامق
              AppColors.backgroundDark, // كحلي متوسط
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }
}
