import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/core/localization/app_localization.dart';
import '../../../../../../core/enum/screen_enum.dart';
import '../cubit.dart';
import '../state.dart';
import 'add_product_dialog.dart';
import 'stat_card.dart';
import 'inventory_table.dart';

class ExpandedStoke extends StatelessWidget {
  const ExpandedStoke({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {

        final items = state.allItems;

        final totalValue = items.fold<double>(
            0,
                (p,e)=> p + (e.price * e.stock)
        );

        final lowProducts =
            items.where((e)=>e.status == InventoryStatus.low).length;

        final totalProducts = items.length;

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatCard(
                    title: TranslationService.tr('total_value'),
                    value: "EGP ${totalValue.toStringAsFixed(0)}",
                    icon: LucideIcons.trendingUp,
                    iconBg: const Color(0xFF123D2A),
                  ),
                  StatCard(
                    title: TranslationService.tr('low_products'),
                    value: lowProducts.toString(),
                    icon: LucideIcons.alertTriangle,
                    iconBg: const Color(0xFF3D1A1A),
                  ),
                  StatCard(
                    title: TranslationService.tr('total_products'),
                    value: totalProducts.toString(),
                    icon: LucideIcons.box,
                    iconBg: const Color(0xFF142B4D),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  _addButton(context),
                  _filterButton(context,"all",InventoryStatus.all),
                  _filterButton(context,"low",InventoryStatus.low),
                  _filterButton(context,"out",InventoryStatus.out),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      onChanged: context.read<InventoryCubit>().search,
                      decoration: InputDecoration(
                        hintText: TranslationService.tr("search"),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: InventoryTable(
                  items: state.filteredItems,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _addButton(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        height: 45,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add,color: Colors.white),
          label: Text(TranslationService.tr("add_product")),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {

            showDialog(
              context: context,
              barrierColor: Colors.black54,
              builder: (_) => BlocProvider.value(
                value: context.read<InventoryCubit>(),
                child: const AddProductDialog(),
              ),
            );

          },
        ),
      ),
    );
  }

  Widget _filterButton(
      BuildContext context,
      String title,
      InventoryStatus status){

    final cubit = context.read<InventoryCubit>();
    final selected = cubit.state.filter == status;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        height:45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            selected
                ? AppColors.primary400
                : AppColors.primary700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: ()=> cubit.filterByStatus(status),
          child: Text(TranslationService.tr(title)),
        ),
      ),
    );
  }
}
