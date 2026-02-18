import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';
import '../../../../core/assets/images.dart';
import '../../../../core/enum/screen_enum.dart';
import '../../../../core/localization/components/lang_button.dart';
import '../cubit.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CompanyDashboardCubit>();
    final current = context.watch<CompanyDashboardCubit>().state.currentPage;


    return Drawer(
      child: Container(
        width: width(context)/4,
        color: AppColors.cardDark,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  logo_backgroundDark,
                  scale: 20,
                ),
                const SizedBox(width: 8),
                const Text('SelliX', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              ],
            ),
            const SizedBox(height: 24),
            _item(context, 'dashboard', LucideIcons.layoutGrid, DashboardPageType.dashboard, current, cubit),
            // _item(context, 'POS', LucideIcons.shoppingCart, DashboardPageType.pos, current, cubit),
            _item(context, 'inventory', LucideIcons.box, DashboardPageType.inventory, current, cubit),
            _item(context, 'employees', LucideIcons.users, DashboardPageType.employees, current, cubit),
            _item(context, 'orders', LucideIcons.receipt, DashboardPageType.orders, current, cubit),
            _item(context, 'reports', LucideIcons.barChart3, DashboardPageType.reports, current, cubit),
            _item(context, 'settings', LucideIcons.settings, DashboardPageType.settings, current, cubit),
            SizedBox(height: height(context) / 4,),
            LangSwitchButton(),
          ],
        ),
      ),
    );
  }


  Widget _item(
      BuildContext context,
      String title,
      IconData icon,
      DashboardPageType page,
      DashboardPageType current,
      CompanyDashboardCubit cubit,
      ) {
    final active = page == current;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2563EB) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(TranslationService.tr(title), style: const TextStyle(color: Colors.white)),
        onTap: () => cubit.changePage(page, context),
      ),
    );
  }
}

