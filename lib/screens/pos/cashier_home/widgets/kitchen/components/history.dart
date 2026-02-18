import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/screens/pos/cashier_home/widgets/kitchen/components/section_board.dart';

import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../core/localization/app_localization.dart';
import '../cubit.dart';
import '../state.dart';

class KitchenHistoryPage extends StatelessWidget {
  const KitchenHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary800,
      child: BlocBuilder<KitchenCubit, KitchenState>(
        builder: (context, state) {
          final sections =
          state.history.map((e) => e.section).toSet().toList();

          return Row(
            children: sections.map((s) {
              final list = state.history
                  .where((e) => e.section == s)
                  .toList();

              return SingleChildScrollView(
                child: SectionBoard(
                  section: s,
                  orders: list,
                  timers: state.timers,
                  historyMode: true,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
