import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/app_colors.dart';
import 'cubit.dart';
import 'state.dart';

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ReportsCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<ReportsCubit>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(child: Text("ReportsPage"),),
    );
  }
}


