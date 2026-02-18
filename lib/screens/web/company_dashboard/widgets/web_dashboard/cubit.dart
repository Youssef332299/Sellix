import 'package:bloc/bloc.dart';

import 'state.dart';

class Web_dashboardCubit extends Cubit<Web_dashboardState> {
  Web_dashboardCubit() : super(Web_dashboardState().init());
}
