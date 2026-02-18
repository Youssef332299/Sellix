import 'package:flutter/material.dart';
import '../../../../../../core/colors/app_colors.dart';

class ChefAnimation extends StatelessWidget {

  final bool active;

  const ChefAnimation({
    super.key,
    required this.active
  });

  @override
  Widget build(BuildContext context){

    return AnimatedScale(
      duration: const Duration(milliseconds:300),
      scale: active?1.15:1,
      child: const Icon(
        Icons.restaurant_menu,
        size:50,
        color: AppColors.primary400,
      ),
    );
  }
}
