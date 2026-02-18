import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/background.dart';
import '../../core/constants/constants.dart';
import '../../core/localization/app_localization.dart';
import '../../core/widgets/primary_button.dart';
import 'components/log_header.dart';
import 'components/pad_number.dart';
import 'components/passowrd_display.dart';
import 'cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Background(
      child: Center(
        child: Container(
          width: width(context) / 3,
          height: height(context) / 1.2,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LogoHeader(),
              const SizedBox(height: 6),
              Text(
                TranslationService.tr('enter_pass'),
                style: const TextStyle(color: Colors.white70,fontSize: 20),
              ),
              const SizedBox(height: 20),
              PasswordDisplay(cubit: cubit),
              const SizedBox(height: 20),
              Expanded(child: NumberPad(cubit: cubit)),
              const SizedBox(height: 20),
              PrimaryButton(
                onTap: () => cubit.onLogin(context),
                text: TranslationService.tr("login"),
                color: AppColors.primary300, width: width(context)/ 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
