import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/colors/app_colors.dart';
import '../cubit.dart';
import '../state.dart';

class PasswordDisplay extends StatelessWidget {
  final AuthCubit cubit;
  const PasswordDisplay({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:AppColors.backgroundGradientEnd,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              cubit.password.length,
                  (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
