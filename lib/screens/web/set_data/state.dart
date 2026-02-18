abstract class SetDataState {}

class SetDataInitial extends SetDataState {}

class SetDataLoading extends SetDataState {}

class SetDataRefresh extends SetDataState {}

class SetDataSuccess extends SetDataState {
  final String companyId;
  SetDataSuccess(this.companyId);
}

class SetDataError extends SetDataState {
  final String message;
  SetDataError(this.message);
}
