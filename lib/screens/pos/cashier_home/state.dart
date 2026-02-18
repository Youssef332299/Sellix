import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/Inventory/Inventory_item_model.dart';
import '../../../core/localization/app_localization.dart';

class PosState {
  final List<InventoryItem> allProducts;
  final List<InventoryItem> filtered;
  final List<String> categories;
  final String selectedCategory;

  final List<Map> cart;

  /// Kitchen
  final String? currentKitchenOrderId;
  final Timestamp? currentKitchenOrderTime;

  /// Order type
  final String orderType;
  final String? deliveryTable;

  /// Payment
  final String paymentMethod; // cash / visa / custom
  final double paidAmount;
  final double cashPaid;
  final double visaPaid;

  PosState({
    required this.allProducts,
    required this.filtered,
    required this.categories,
    required this.selectedCategory,
    required this.cart,
    required this.currentKitchenOrderId,
    required this.currentKitchenOrderTime,
    required this.orderType,
    required this.deliveryTable,
    required this.paymentMethod,
    required this.paidAmount,
    this.cashPaid = 0,
    this.visaPaid = 0,
  });

  factory PosState.init({
    List<InventoryItem>? allProducts,
    List<String>? categories,
    String? selectedCategory,
  }) {
    return PosState(
      allProducts: allProducts ?? [],
      filtered: allProducts ?? [],
      categories: categories ?? [TranslationService.tr('all')],
      selectedCategory: selectedCategory ?? TranslationService.tr('all'),
      cart: [],
      currentKitchenOrderId: null,
      currentKitchenOrderTime: null,
      orderType: "Pickup",
      deliveryTable: null,
      paymentMethod: "cash",
      paidAmount: 0,
      cashPaid: 0,
      visaPaid: 0,
    );
  }

  PosState copyWith({
    List<InventoryItem>? allProducts,
    List<InventoryItem>? filtered,
    List<String>? categories,
    String? selectedCategory,
    List<Map>? cart,
    String? currentKitchenOrderId,
    Timestamp? currentKitchenOrderTime,
    String? orderType,
    String? deliveryTable,
    String? paymentMethod,
    double? paidAmount,
    double? cashPaid,
    double? visaPaid,
  }) {
    return PosState(
      allProducts: allProducts ?? this.allProducts,
      filtered: filtered ?? this.filtered,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      cart: cart ?? this.cart,
      currentKitchenOrderId: currentKitchenOrderId ?? this.currentKitchenOrderId,
      currentKitchenOrderTime: currentKitchenOrderTime ?? this.currentKitchenOrderTime,
      orderType: orderType ?? this.orderType,
      deliveryTable: deliveryTable ?? this.deliveryTable,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidAmount: paidAmount ?? this.paidAmount,
      cashPaid: cashPaid ?? this.cashPaid,
      visaPaid: visaPaid ?? this.visaPaid,
    );
  }
}
