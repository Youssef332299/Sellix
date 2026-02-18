import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sellix/models/Inventory/Inventory_item_model.dart';

class InventoryRepository {

  final _db = FirebaseFirestore.instance;

  CollectionReference itemsRef(String companyId){
    return _db
        .collection('companies')
        .doc(companyId)
        .collection('items');
  }

  Stream<List<InventoryItem>> getItems(String companyId){
    return itemsRef(companyId).snapshots().map((snapshot){
      return snapshot.docs.map((d){
        return InventoryItem.fromMap(
            d.id,
            d.data() as Map<String,dynamic>);
      }).toList();
    });
  }

  Future<void> addItem(String companyId,InventoryItem item) async{
    await itemsRef(companyId).add(item.toMap());
  }

  Future<void> updateItem(String companyId,InventoryItem item) async{
    await itemsRef(companyId).doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String companyId,String id) async{
    await itemsRef(companyId).doc(id).delete();
  }
}
