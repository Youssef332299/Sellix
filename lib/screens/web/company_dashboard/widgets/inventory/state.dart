import '../../../../../core/enum/screen_enum.dart';
import '../../../../../models/Inventory/Inventory_item_model.dart';

class InventoryState {
  final List<InventoryItem> allItems;
  final List<InventoryItem> filteredItems;
  final String search;
  final InventoryStatus filter;

  InventoryState({
    required this.allItems,
    required this.filteredItems,
    required this.search,
    required this.filter,
  });

  factory InventoryState.init() {
    return InventoryState(
      allItems: [],
      filteredItems: [],
      search: '',
      filter: InventoryStatus.all,
    );
  }

  InventoryState copyWith({
    List<InventoryItem>? allItems,
    List<InventoryItem>? filteredItems,
    String? search,
    InventoryStatus? filter,
  }) {
    return InventoryState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      search: search ?? this.search,
      filter: filter ?? this.filter,
    );
  }
}
