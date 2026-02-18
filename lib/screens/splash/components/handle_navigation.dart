import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/screens/mobile/admin_home/view.dart';
import 'package:sellix/screens/mobile/employee_home/view.dart';
import 'package:sellix/screens/mobile/select_user_type/view.dart';
import 'package:sellix/screens/pos/cashier_home/view.dart';
import 'package:sellix/screens/splash/state.dart';
import 'package:sellix/screens/web/company_dashboard/view.dart';
import 'package:sellix/screens/web/web_admin_login/view.dart';
import '../../../core/enum/screen_enum.dart';
import '../../../core/navigation/navigation.dart';
import 'package:sellix/core/constants/constants.dart';
import 'package:sellix/core/widgets/snack_bar.dart';
import '../../auth/view.dart';
import '../cubit.dart';

class HandleNavigation extends StatelessWidget {
  HandleNavigation({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          _handleNavigation(context, state);
        }

        if (state is SplashError) {
          showSnackBar(context, state.message);
        }
      },
      child: child,
    );
  }

  void _handleNavigation(BuildContext context, SplashNavigate state) {
    final platform = state.platform;
    // firstTime = state.firstTime;

    print("FirstTime: $firstTime");
    print("platform: ${platform}");
    print("kIsWeb: ${kIsWeb}");

    if (firstTime) {
      if (kIsWeb) {
        navigateAndRemoveUntilWithScale(context, Web_admin_loginPage());
      } else {
        navigateAndRemoveUntilWithScale(context, Select_user_typePage());
      }
      return;
    }

    switch (platform) {
      case AppPlatform.android:
      case AppPlatform.ios:
        isAdmin
            ? navigateAndRemoveUntilWithScale(context, Admin_homePage())
            : navigateAndRemoveUntilWithScale(context, Employee_homePage());
        return;

      default:
        navigateAndRemoveUntilWithScale(context, AuthPage());
        return;
    }
  }
}
