import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/employees/view.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/inventory/view.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/orders/view.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/reports/view.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/settings/view.dart';
import 'package:sellix/screens/web/company_dashboard/widgets/web_dashboard/view.dart';
import '../../../core/enum/screen_enum.dart';
import 'cubit.dart';
import 'state.dart';
import 'components/side_bar.dart';


class CompanyDashboardPage extends StatelessWidget {
  const CompanyDashboardPage({super.key, required String companyId});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompanyDashboardCubit(),
      child: BlocBuilder<CompanyDashboardCubit, CompanyDashboardState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.backgroundDark,
            ),
            backgroundColor: AppColors.backgroundDark,
            drawer: const SideBar(),
            body: Row(
              children: [
                Expanded(child: _buildBody(state.currentPage)),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildBody(DashboardPageType page) {
    switch (page) {
      case DashboardPageType.dashboard:
        return Web_dashboardPage();
      case DashboardPageType.inventory:
        return InventoryPage();
      case DashboardPageType.employees:
        return  EmployeesPage();
      case DashboardPageType.orders:
        return OrdersPage();
      case DashboardPageType.reports:
        return ReportsPage();
      case DashboardPageType.settings:
        return SettingsPage();
    }
  }
}
