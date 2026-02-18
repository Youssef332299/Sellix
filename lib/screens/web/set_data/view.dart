import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/core/constants/constants.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/navigation/navigation.dart';
import 'package:sellix/core/widgets/background.dart';
import 'package:sellix/core/widgets/primary_button.dart';
import 'package:sellix/core/widgets/snack_bar.dart';
import 'package:sellix/screens/web/company_dashboard/view.dart';
import '../../../core/screen size/screen_size.dart';
import '../company_dashboard/widgets/web_dashboard/view.dart';
import 'components/company_form.dart';
import 'cubit.dart';
import 'state.dart';

class SetDataPage extends StatelessWidget {
  SetDataPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final aboutController = TextEditingController();
  final ordersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SetDataCubit(),
      child: BlocConsumer<SetDataCubit, SetDataState>(
        listener: (context, state) {
          if (state is SetDataSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                // scrollable: false,

                title: Center(child: Text("✅ ${TranslationService.tr("save_success")}")),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${TranslationService.tr("company_id")} : ${state.companyId}"),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: state.companyId));
                            showSnackBar(context, "${TranslationService.tr('copied')} ID");
                          },
                          icon: const Icon(Icons.copy),
                          label: Text("${TranslationService.tr('copy')} ID"),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: width(context)/ 3,
                          child: PrimaryButton(onTap: (){
                            Navigator.pop(context);
                            companyId = state.companyId;
                            navigateAndRemoveUntilWithScale(context, CompanyDashboardPage(companyId: companyId));
                          }, text: TranslationService.tr('start_now'), color: AppColors.primary400, width: width(context) / 4,),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is SetDataError) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return Background(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width(context) / 10, vertical: 50),
                child: CompanyForm(
                  formKey: _formKey,
                  nameController: nameController,
                  passwordController: passwordController,
                  aboutController: aboutController,
                  ordersController: ordersController,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
