import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sellix/screens/pos/cashier_home/components/day_report.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/navigation/navigation.dart';
import '../widgets/kitchen/view.dart';

class PopUpMore extends StatelessWidget {
  const PopUpMore({super.key});

  List<String> _randomCommands() {
    final commands = [
      "الفواتير المعلق",
      "التقارير الشهرية",
      "التقارير اليومية",
      "المنتجات المباعة",
      "الطاولات",
    ];
    return commands;
  }

  @override
  Widget build(BuildContext context) {

    final commands = _randomCommands(); // نولدهم مرة واحدة

    return PopupMenuButton<String>(
      tooltip: "المزيد",
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.textPrimary,
      ),
      color: AppColors.cardDark,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        if (value == "kitchen") {
          navigateWithScale(context, const KitchenPage());
        }else if(value == "التقارير الشهرية"){
          navigateBackWithScale(context, ReportsPage());
        }
      },
      itemBuilder: (context) => [

        /// أوامر عشوائية
        ...commands.map(
              (cmd) => PopupMenuItem<String>(
            value: cmd,
            child: Text(
              cmd,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const PopupMenuDivider(),

        /// زر المطبخ
        const PopupMenuItem<String>(
          value: "kitchen",
          child: Row(
            children: [
              Icon(Icons.restaurant, color: AppColors.primary400),
              SizedBox(width: 8),
              Text(
                "الذهاب إلى صفحة المطبخ",
                style: TextStyle(
                  color: AppColors.primary400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
