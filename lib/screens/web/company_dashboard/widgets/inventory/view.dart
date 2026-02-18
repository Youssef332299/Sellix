import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/constants/constants.dart';
import 'components/inventory_repo.dart';
import 'cubit.dart';
import 'components/expanded_stoke.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => InventoryCubit(
        InventoryRepository(),
        companyId,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: const ExpandedStoke(),
      ),
    );
  }
}
