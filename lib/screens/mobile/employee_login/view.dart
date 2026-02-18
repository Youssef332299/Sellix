import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/navigation/navigation.dart';
import 'package:sellix/core/widgets/snack_bar.dart';
import 'package:sellix/screens/mobile/employee_home/view.dart';
import 'components/employee_field.dart';
import 'components/remember_me_checkbox.dart';
import 'cubit.dart';

class EmployeeLoginPage extends StatefulWidget {
  const EmployeeLoginPage({super.key});

  @override
  State<EmployeeLoginPage> createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginPage> {
  final _idController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeLoginCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<EmployeeLoginCubit, EmployeeLoginState>(
            listener: (context, state) {
              if (state is EmployeeLoginSuccess) {
                navigateWithScale(context, Employee_homePage());
              }
              if (state is EmployeeLoginError) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  EmployeeIdField(controller: _idController),
                  const SizedBox(height: 12),
                  RememberMeCheckbox(
                    value: rememberMe,
                    onChanged: (v) => setState(() => rememberMe = v),
                  ),
                  const SizedBox(height: 20),
                  if (state is EmployeeLoginLoading)
                    const CircularProgressIndicator()
                  else
                    MaterialButton(
                      child: Text('Login'),
                      onPressed: () {
                        context.read<EmployeeLoginCubit>().login(
                          _idController.text,
                          rememberMe,
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
