import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../models/kitchen/kitchen_model.dart';

class KitchenRepo {

  final _ref = FirebaseFirestore.instance
      .collection("companies")
      .doc(companyId)
      .collection("kitchen_orders");

  Stream<List<KitchenOrder>> listenOrders() {
    return _ref
        .orderBy("time", descending: true)
        .snapshots()
        .map((snap) {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      return snap.docs
          .map((e) => KitchenOrder.fromJson(e.data()))
          .where((order) =>
          order.time.toDate().isAfter(startOfDay))
          .toList();
    });
  }

  Future sendOrder(KitchenOrder order){
    return _ref.doc(order.id).set(order.toJson());
  }

  Future updateStatus(String id,String status){
    return _ref.doc(id).update({"status":status});
  }
}
