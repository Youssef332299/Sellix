import 'package:bloc/bloc.dart';

import 'state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceState().init());
}
