import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sellix/core/widgets/text_icon_button.dart';
import 'package:sellix/screens/pos/cashier_home/components/pop_up_more.dart';
import 'package:sellix/screens/pos/cashier_home/components/product_grid.dart';
import 'package:sellix/screens/pos/cashier_home/components/search_bar.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/screen size/screen_size.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit.dart';
import '../widgets/kitchen/view.dart';
import 'category_tabs.dart';

class RightSide extends StatelessWidget {
  const RightSide({
    super.key,
    required this.table,
    required this.seat,
    required this.section,
  });

  final String table;
  final String seat;
  final String section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColors.cardDark,
          ),
          height: 100,
          width: width(context) / 1.4,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextIconButton(onTap: () {

              }, text: TranslationService.tr('print'), color: AppColors.primary600, icon: LucideIcons.printer),
              TextIconButton(onTap: () {}, text: TranslationService.tr('new'), color: AppColors.primary600, icon: LucideIcons.badgePlus),
              TextIconButton(onTap: () {
                context.read<PosCubit>().sendToKitchen(
                  context: context,
                  table: "T1",
                  seat: "1",
                  section: "Main",
                );
              }, text: TranslationService.tr('kitchen'), color: AppColors.primary600, icon: LucideIcons.chefHat),
              TextIconButton(onTap: () {}, text: TranslationService.tr('orders'), color: AppColors.primary600, icon: LucideIcons.clock),
              TextIconButton(onTap: () {}, text: TranslationService.tr('void'), color: AppColors.primary600, icon: LucideIcons.ban),
              TextIconButton(     onTap: () => _showDiscountDialog(context),
                  text: TranslationService.tr('discount'), color: AppColors.primary600, icon: LucideIcons.badgePercent),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PopUpMore(),
                  const SizedBox(height: 4),
                  Text(
                    TranslationService.tr('more'),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SearchBarPOS(),

        const SizedBox(height: 14),

        const CategoryTabs(),

        const Expanded(child: ProductGrid()),
      ],
    );
  }
}
void _showDiscountDialog(BuildContext context) {
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(TranslationService.tr("enter_discount")),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: TranslationService.tr("discount_percent"),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final value =
                  double.tryParse(controller.text) ?? 0;
              context.read<PosCubit>().setDiscount(value);
              Navigator.pop(context);
            },
            child: Text(TranslationService.tr("save")),
          ),
        ],
      );
    },
  );
}
