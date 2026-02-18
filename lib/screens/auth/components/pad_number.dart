import 'package:flutter/material.dart';
import '../cubit.dart';
import 'key_button.dart';
import '../../../core/colors/app_colors.dart';

class NumberPad extends StatelessWidget {
  final AuthCubit cubit;
  const NumberPad({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        if (index == 9) {
          return KeyButton(
            onTap: () => cubit.onClear(),
            text: 'C',
            color: AppColors.primary600,
          );
        }
        if (index == 10) {
          return KeyButton(
            text: '0',
            onTap: () => cubit.onNumberPress('0'),
            color: AppColors.primary600,
          );
        }
        if (index == 11) {
          return KeyButton(
            text: "<",
            onTap: () => cubit.onDelete(),
            color: AppColors.primary600,
          );
        }
        return KeyButton(
          text: '${index + 1}',
          onTap: () => cubit.onNumberPress('${index + 1}'),
          color: AppColors.primary600,
        );
      },
    );
  }
}
