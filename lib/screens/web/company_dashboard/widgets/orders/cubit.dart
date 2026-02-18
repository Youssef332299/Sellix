import 'package:bloc/bloc.dart';

import 'state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState().init());
}
