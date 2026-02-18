import 'package:bloc/bloc.dart';

import 'state.dart';

class Employee_homeCubit extends Cubit<Employee_homeState> {
  Employee_homeCubit() : super(Employee_homeState().init());
}
