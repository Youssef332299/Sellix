import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/navigation/navigation.dart';
import 'package:sellix/core/widgets/primary_button.dart';
import 'package:sellix/screens/pos/cashier_home/components/right_side.dart';
import 'package:sellix/screens/pos/cashier_home/widgets/kitchen/view.dart';
import '../../../core/colors/app_colors.dart';
import 'cubit.dart';
import 'components/cart_panel.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PosCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primary800,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: const [
              Expanded(flex: 3, child: RightSide(
                table: "T1",
                seat: "S1",
                section: "Kitchen",
              )),
              Expanded(flex: 1, child: CartPanel(

              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
