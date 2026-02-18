import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit.dart';

class SaveSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController aboutController;
  final TextEditingController ordersController;

  const SaveSection({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.passwordController,
    required this.aboutController,
    required this.ordersController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetDataCubit>();

    return PrimaryButton(
      color: AppColors.primary400,
      text: TranslationService.tr("save_data"),
      onTap: () {
        if (!formKey.currentState!.validate()) return;

        cubit.saveCompany(
          name: nameController.text,
          password: passwordController.text,
          about: aboutController.text,
          phones: cubit.getValues(cubit.phones),
          complaints: cubit.getValues(cubit.complaints),
          branches: cubit.getValues(cubit.branches),
          ordersInfo: ordersController.text,
        );
      }, width: width(context) / 3,
    );
  }
}
