import 'package:bloc/bloc.dart';

import 'state.dart';

class Admin_homeCubit extends Cubit<Admin_homeState> {
  Admin_homeCubit() : super(Admin_homeState().init());
}
