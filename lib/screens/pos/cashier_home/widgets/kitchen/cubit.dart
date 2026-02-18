import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/screens/pos/cashier_home/widgets/kitchen/state.dart';
import '../../../../../models/kitchen/kitchen_model.dart';
import 'components/kitchen_repo.dart';

class KitchenCubit extends Cubit<KitchenState> {
  KitchenCubit() : super(KitchenState.initial()) {
    _listen();
    _startTimer();
  }

  final KitchenRepo repo = KitchenRepo();

  Timer? _timer;
  StreamSubscription<List<KitchenOrder>>? _ordersSubscription;

  /* ================= LISTEN ORDERS ================= */

  void _listen() {
    _ordersSubscription = repo.listenOrders().listen((orders) {
      if (isClosed) return; // حماية مهمة جداً
      emit(state.copyWith(orders: orders));
    });
  }

  /* ================= BUMP ================= */

  void bump(KitchenOrder order) {
    final newOrders = List<KitchenOrder>.from(state.orders)
      ..removeWhere((o) => o.id == order.id);

    final newHistory = List<KitchenOrder>.from(state.history)..add(order);

    emit(state.copyWith(
      orders: newOrders,
      history: newHistory,
    ));
  }

  /* ================= RESTORE ================= */

  void restore(KitchenOrder order) {
    final newOrders = List<KitchenOrder>.from(state.orders)..add(order);

    final newHistory = List<KitchenOrder>.from(state.history)
      ..removeWhere((o) => o.id == order.id);

    emit(state.copyWith(
      orders: newOrders,
      history: newHistory,
    ));
  }

  /* ================= TIMER ================= */

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;

      final map = <String, int>{};
      final now = DateTime.now();

      for (final o in state.orders) {
        final orderTime = o.time.toDate();
        final seconds = now.difference(orderTime).inSeconds;
        map[o.id] = seconds;
      }

      emit(state.copyWith(timers: map));
    });
  }

  /* ================= CLOSE ================= */

  @override
  Future<void> close() async {
    await _ordersSubscription?.cancel(); // مهم جداً
    _timer?.cancel();
    return super.close();
  }
}
