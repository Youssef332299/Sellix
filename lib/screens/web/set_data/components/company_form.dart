import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/assets/images.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';
import 'package:sellix/screens/web/set_data/components/custom_text_field.dart';
import 'package:sellix/screens/web/set_data/components/dynamic_list_field.dart';
import 'package:sellix/screens/web/set_data/components/save_section.dart';
import '../cubit.dart';
import '../state.dart';
import '../../../../core/localization/app_localization.dart';
import 'company_header.dart';

class CompanyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController aboutController;
  final TextEditingController ordersController;

  const CompanyForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.passwordController,
    required this.aboutController,
    required this.ordersController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SetDataCubit>();

    return Container(
      // width: width(context) / 1.1,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2F44),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const CompanyHeader(),
            const SizedBox(height: 30),

            CustomTextField(
              controller: nameController,
              label: TranslationService.tr("company_name"),
              validator: cubit.validateName,
            ),

            CustomTextField(
              controller: passwordController,
              label: TranslationService.tr("company_password"),
              validator: cubit.validatePassword,
              keyboardType: TextInputType.number,
            ),

            CustomTextField(
              controller: aboutController,
              label: TranslationService.tr("about_company"),
              maxLines: 3,
            ),

            CustomTextField(
              controller: ordersController,
              label: TranslationService.tr("orders_info"),
              maxLines: 3,
            ),

            DynamicListField(
              title: TranslationService.tr("phones"),
              controllers: cubit.phones,
              onAdd: cubit.addPhone,
              onRemove: cubit.removePhone,
              validator: cubit.validateNumber,
            ),

            DynamicListField(
              title: TranslationService.tr("complaints"),
              controllers: cubit.complaints,
              onAdd: cubit.addComplaint,
              onRemove: cubit.removeComplaint,
              validator: cubit.validateNumber,
            ),

            DynamicListField(
              title: TranslationService.tr("branches"),
              controllers: cubit.branches,
              onAdd: cubit.addBranch,
              onRemove: cubit.removeBranch,
            ),

            const SizedBox(height: 20),

            SaveSection(
              formKey: formKey,
              nameController: nameController,
              passwordController: passwordController,
              aboutController: aboutController,
              ordersController: ordersController,
            )
          ],
        ),
      ),
    );
  }
}
