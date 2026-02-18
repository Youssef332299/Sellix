import 'package:flutter/material.dart';
import 'package:sellix/core/screen size/screen_size.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../models/Inventory/Inventory_item_model.dart';

class ProductCard extends StatefulWidget {
  final InventoryItem item;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // width: width(context) / 1,
          // height: height(context) / 3,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isHover
                  ? AppColors.primary400
                  : AppColors.borderLight,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHover
                    ? AppColors.primary500.withOpacity(0.5)
                    : Colors.black.withOpacity(0.15),
                blurRadius: isHover ? 25 : 10,
                spreadRadius: isHover ? 1 : 0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                widget.item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "EGP ${widget.item.price}",
                style: const TextStyle(
                  color: AppColors.primary300,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
