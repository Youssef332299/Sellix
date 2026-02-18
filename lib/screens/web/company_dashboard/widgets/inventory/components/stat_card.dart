import 'package:flutter/material.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';
import '../../../../../../core/colors/app_colors.dart';


class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconBg;

  const StatCard({super.key, required this.title, required this.value, required this.icon, required this.iconBg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context)/ 3.3,
        height: height(context) / 6,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary700,
          border: Border.all(color: AppColors.textMuted),
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70)),
                Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.white),
            )
          ],
        ),
    );
  }
}