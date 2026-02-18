import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'cubit.dart';

class Web_dashboardPage extends StatelessWidget {
  const Web_dashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Web_dashboardCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<Web_dashboardCubit>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(child: Text("Web_dashboardPage" ,),),
    );
  }
}


