import 'package:bloc/bloc.dart';

import 'state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsState().init());
}
