import 'package:flutter/material.dart';
import 'package:sellix/core/constants/constants.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';
import 'package:sellix/core/widgets/primary_button.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../core/localization/app_localization.dart';
import '../../../../../../models/kitchen/kitchen_model.dart';

class OrderCard extends StatelessWidget {
  final KitchenOrder order;
  final int index;
  final int seconds;
  final bool small;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.index,
    required this.seconds,
    required this.onTap,
    this.small = false,
  });

  Color getColor() {
    if (order.changed) return AppColors.primary400;
    if (seconds > 300) return AppColors.error;
    return AppColors.success;
  }

  String formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;

    return "${h.toString().padLeft(2, '0')}:"
        "${m.toString().padLeft(2, '0')}:"
        "${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Container(
      width: width(context) / 5,
      height: small ? 150 : height(context) / 1.02, // 👈 هنا الحل
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [

          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order #${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatTime(seconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "${order.orderType} ${order.deliveryTable ?? ''}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          /// ================= ITEMS =================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: order.items.length,
              itemBuilder: (context, i) {
                final item = order.items[i];
                final name = item['name']?.toString() ?? '';
                final qty = item['qty']?.toString() ?? '0';
                final note = item['note']?.toString() ?? '';

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: cairoFonts,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "x$qty",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (note.isNotEmpty)
                        Text(
                          note,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// ================= BUTTON =================
          Padding(
            padding: const EdgeInsets.all(8),
            child: PrimaryButton(
              onTap: onTap,
              text: small
                  ? TranslationService.tr("restore")
                  : TranslationService.tr("bump"),
              color: AppColors.primary800,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
