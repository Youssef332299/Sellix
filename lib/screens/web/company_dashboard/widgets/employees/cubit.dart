import 'package:bloc/bloc.dart';

import 'state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit() : super(EmployeesState().init());
}
