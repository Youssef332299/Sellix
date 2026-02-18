part of 'cubit.dart';

abstract class EmployeeLoginState {}

class EmployeeLoginInitial extends EmployeeLoginState {}

class EmployeeLoginLoading extends EmployeeLoginState {}

class EmployeeLoginSuccess extends EmployeeLoginState {
  final String employeeId;
  EmployeeLoginSuccess(this.employeeId);
}

class EmployeeLoginError extends EmployeeLoginState {
  final String message;
  EmployeeLoginError(this.message);
}
