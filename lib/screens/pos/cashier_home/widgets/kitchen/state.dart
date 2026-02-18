import '../../../../../models/kitchen/kitchen_model.dart';

class KitchenState {
  final List<KitchenOrder> orders;
  final List<KitchenOrder> history;
  final Map<String, int> timers;

  KitchenState({
    required this.orders,
    required this.history,
    required this.timers,
  });

  factory KitchenState.initial() {
    return KitchenState(
      orders: [],
      history: [],
      timers: {},
    );
  }

  KitchenState copyWith({
    List<KitchenOrder>? orders,
    List<KitchenOrder>? history,
    Map<String, int>? timers,
  }) {
    return KitchenState(
      orders: orders ?? this.orders,
      history: history ?? this.history,
      timers: timers ?? this.timers,
    );
  }
}
