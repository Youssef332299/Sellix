import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class EmployeeLoginCubit extends Cubit<EmployeeLoginState> {
  EmployeeLoginCubit() : super(EmployeeLoginInitial());

  void login(String employeeId, bool rememberMe) async {
    emit(EmployeeLoginLoading());

    if (employeeId.isEmpty) {
      emit(EmployeeLoginError('Employee ID مطلوب'));
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    emit(EmployeeLoginSuccess(employeeId));
  }
}
