import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/screens/web/web_admin_login/components/fireworks.dart';

import 'components/animated_text.dart';
import 'cubit.dart';

class Web_admin_loginPage extends StatelessWidget {
  const Web_admin_loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Web_admin_loginCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: FireworksBackground(child: AnimatedTextStart())
      ),
    );
  }
}


