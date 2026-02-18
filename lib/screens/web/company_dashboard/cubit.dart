import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/enum/screen_enum.dart';
import 'state.dart';


class CompanyDashboardCubit extends Cubit<CompanyDashboardState> {
  CompanyDashboardCubit() : super(CompanyDashboardState.initial());


  void changePage(DashboardPageType page, context) {
    emit(state.copyWith(currentPage: page));
    Navigator.of(context).pop();
  }
}