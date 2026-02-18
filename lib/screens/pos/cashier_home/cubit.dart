import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/constants/constants.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/widgets/snack_bar.dart';
import 'package:sellix/screens/pos/cashier_home/widgets/kitchen/components/kitchen_repo.dart';
import 'package:sellix/screens/pos/cashier_home/widgets/kitchen/components/kitchen_sonud_services.dart';
import '../../../models/kitchen/kitchen_model.dart';
import '../../../models/Inventory/Inventory_item_model.dart';
import '../../web/company_dashboard/widgets/inventory/components/inventory_repo.dart';
import 'state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosState.init()) {
    _listenProducts();
  }

  final kitchenRepo = KitchenRepo();
  String _searchText = "";
  bool _isSending = false;

  void setDiscount(double value) {
    emit(state.copyWith());
  }
  void _listenProducts() {
    InventoryRepository().getItems(companyId).listen((data) {
      data.sort((a, b) => b.soldCount.compareTo(a.soldCount));
      final cats = data.map((e) => e.category).toSet().toList();
      emit(state.copyWith(
        allProducts: data,
        filtered: data,
        categories: [TranslationService.tr('all'), ...cats],
        selectedCategory: TranslationService.tr('all'),
      ));
    });
  }

  void selectCategory(String cat) {
    if (cat == TranslationService.tr('all')) {
      emit(state.copyWith(selectedCategory: cat, filtered: _applySearch(state.allProducts)));
      return;
    }
    final filtered = state.allProducts.where((e) => e.category == cat).toList();
    emit(state.copyWith(selectedCategory: cat, filtered: _applySearch(filtered)));
  }

  void search(String text) {
    _searchText = text;
    emit(state.copyWith(filtered: _applySearch(state.allProducts)));
  }

  List<InventoryItem> _applySearch(List<InventoryItem> list) {
    if (_searchText.isEmpty) return list;
    return list.where((e) => e.name.toLowerCase().contains(_searchText.toLowerCase())).toList();
  }

  void addToCart(InventoryItem item) {
    final cart = List<Map>.from(state.cart);
    final index = cart.indexWhere((e) => e['id'] == item.id);
    if (index != -1) {
      cart[index]['qty']++;
    } else {
      cart.add({"id": item.id, "name": item.name, "price": item.price, "qty": 1, "state": false, "note": ""});
    }
    emit(state.copyWith(cart: cart));
  }

  void addNote(String id, String note) {
    final cart = List<Map>.from(state.cart);
    final index = cart.indexWhere((e) => e['id'] == id);
    if (index != -1) {
      cart[index]['note'] = note;
      emit(state.copyWith(cart: cart));
    }
  }

  void removeFromCart(String id) {
    final cart = state.cart.where((e) => e['id'] != id).toList();
    emit(state.copyWith(cart: cart));
  }

  void addItem(Map item) {
    final cart = List<Map>.from(state.cart);
    final index = cart.indexWhere((e) => e['id'] == item['id']);
    if (index != -1) cart[index]['qty']++;
    emit(state.copyWith(cart: cart));
  }

  void removeItem(Map item) {
    final cart = List<Map>.from(state.cart);
    final index = cart.indexWhere((e) => e['id'] == item['id']);
    if (index != -1) {
      if (cart[index]['qty'] == 1) {
        cart.removeAt(index);
      } else {
        cart[index]['qty']--;
      }
    }
    emit(state.copyWith(cart: cart));
  }

  void setOrderType(String type) => emit(state.copyWith(orderType: type, deliveryTable: type == "Dine In" ? state.deliveryTable : null));

  void selectDeliveryTable(String table) => emit(state.copyWith(deliveryTable: table));

  void setPaymentMethod(String method) => emit(state.copyWith(paymentMethod: method));

  void setPaidAmount(double amount) => emit(state.copyWith(
    paidAmount: amount,
    cashPaid: state.paymentMethod == "cash" ? amount : state.cashPaid,
    visaPaid: state.paymentMethod == "visa" ? amount : state.visaPaid,
  ));

  void setCashPaid(double amount) => emit(state.copyWith(cashPaid: amount, paidAmount: amount + state.visaPaid));

  // void setVisaPaid(double amount) => emit(state.copyWith(visaPaid: amount, paidAmount: amount + state.cashPaid));

  // Future<void> completeOrder({
  //   required BuildContext context,
  //   required String method,
  //   required double paid,
  //   required double total,
  // })
  // async {
  //   if (state.cart.isEmpty) return;
  //   final invoiceId = DateTime.now().millisecondsSinceEpoch.toString();
  //   final items = state.cart.map((e) => {"id": e['id'], "name": e['name'], "price": e['price'], "qty": e['qty']}).toList();
  //
  //   await FirebaseFirestore.instance.collection("paid_invoices").doc(invoiceId).set({
  //     "items": items,
  //     "total": total,
  //     "paid": paid,
  //     "change": paid - total,
  //     "paymentMethod": method,
  //     "cashPaid": state.cashPaid,
  //     "visaPaid": state.visaPaid,
  //     "orderType": state.orderType,
  //     "table": state.deliveryTable,
  //     "time": Timestamp.now(),
  //   });
  //
  //   /// reset cart only, keep products & categories
  //   emit(PosState.init(
  //     allProducts: state.allProducts,
  //     categories: state.categories,
  //     selectedCategory: state.selectedCategory,
  //   ));
  //   Navigator.pop(context);
  // }

  void nextCategory() {
    if (state.categories.isEmpty) return;

    final currentIndex =
    state.categories.indexOf(state.selectedCategory);

    if (currentIndex < state.categories.length - 1) {
      selectCategory(state.categories[currentIndex + 1]);
    }
  }

  void previousCategory() {
    if (state.categories.isEmpty) return;

    final currentIndex =
    state.categories.indexOf(state.selectedCategory);

    if (currentIndex > 0) {
      selectCategory(state.categories[currentIndex - 1]);
    }
  }

  void listenProducts() {
    InventoryRepository().getItems(companyId).listen((data) {
      data.sort((a, b) => b.soldCount.compareTo(a.soldCount));

      final cats = data.map((e) => e.category).toSet().toList();

      emit(
        state.copyWith(
          allProducts: data,
          filtered: data,
          categories: [TranslationService.tr('all'), ...cats],
          selectedCategory: TranslationService.tr('all'),
        ),
      );
    });
  }

  List<InventoryItem> applySearch(List<InventoryItem> list) {
    if (_searchText.isEmpty) return list;

    return list
        .where((e) =>
        e.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  Future<void> sendToKitchen({
    required BuildContext context,
    required String table,
    required String seat,
    required String section,
    int priority = 1,
  })
  async {

    if (_isSending) return;

    final unsentItems =
    state.cart.where((e) => e['state'] == false).toList();

    if (state.cart.isEmpty) {
      showSnackBar(context, TranslationService.tr("cart_empty"));
      return;
    }

    if (unsentItems.isEmpty) {
      showSnackBar(context, TranslationService.tr("no_new_items"));
      return;
    }

    _isSending = true;

    try {
      KitchenSoundService().newOrder();

      final orderId =
          state.currentKitchenOrderId ??
              DateTime.now().millisecondsSinceEpoch.toString();

      final order = KitchenOrder(
        id: orderId,
        table: table,
        seat: seat,
        section: section,
        priority: priority,
        time: state.currentKitchenOrderTime ?? Timestamp.now(),
        status: "pending",
        changed: state.currentKitchenOrderId != null,
        items: List<Map<String, dynamic>>.from(
          state.cart.map((e) => Map<String, dynamic>.from(e)),
        ),
        orderType: state.orderType,
        deliveryTable: state.deliveryTable,
      );

      await kitchenRepo.sendOrder(order);

      final updatedCart = state.cart.map((e) {
        final item = Map<String, dynamic>.from(e);
        item['state'] = true;
        return item;
      }).toList();

      emit(
        state.copyWith(
          cart: updatedCart,
          currentKitchenOrderId: orderId,
          currentKitchenOrderTime: order.time,
        ),
      );

    } catch (e) {
      showSnackBar(context, TranslationService.tr("order_send_failed"));
    }

    _isSending = false;
  }


  void setVisaPaid(double amount, double total) {
    if (amount >= total) {
      // validation: visa cannot exceed or equal total
      return;
    }
    emit(state.copyWith(visaPaid: amount, paidAmount: state.cashPaid + amount));
  }

  Future<void> completeOrder({
    required BuildContext context,
    required String method,
    required double total,
  }) async {
    if (state.cart.isEmpty) return;

    // Validation
    if (state.visaPaid >= total) {
      showSnackBar(context, TranslationService.tr("visa_exceed_total"));
      return;
    }

    final invoiceId = DateTime.now().millisecondsSinceEpoch.toString();
    final items = state.cart.map((e) => {
      "id": e['id'],
      "name": e['name'],
      "price": e['price'],
      "qty": e['qty'],
    }).toList();

    await FirebaseFirestore.instance.collection("paid_invoices").doc(invoiceId).set({
      "items": items,
      "total": total,
      "paid": state.paidAmount,
      "change": state.paidAmount - total,
      "paymentMethod": method,
      "cashPaid": state.cashPaid,
      "visaPaid": state.visaPaid,
      "orderType": state.orderType,
      "table": state.deliveryTable,
      "time": Timestamp.now(),
    });

    emit(PosState.init(
      allProducts: state.allProducts,
      categories: state.categories,
      selectedCategory: state.selectedCategory,
    ));

    Navigator.pop(context);
  }
}
