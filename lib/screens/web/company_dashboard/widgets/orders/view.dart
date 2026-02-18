import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/app_colors.dart';
import 'cubit.dart';
import 'state.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OrdersCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<OrdersCubit>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(child: Text("OrdersPage"),),
    );  }
}


