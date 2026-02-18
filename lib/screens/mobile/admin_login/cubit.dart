import 'package:bloc/bloc.dart';

import 'state.dart';

class Admin_loginCubit extends Cubit<Admin_loginState> {
  Admin_loginCubit() : super(Admin_loginState().init());
}
