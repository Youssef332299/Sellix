import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseService {

  static final _db = FirebaseFirestore.instance;

  static Future<void> init() async {
    await Firebase.initializeApp();
  }
  // check tenant
  static Future<bool> checkTenant(String tenantId) async {
    try {
      final doc = await _db.collection(tenantId).doc(tenantId).get();
      print('checkTenant: path=${doc.reference.path}, exists=${doc.exists}');
      return doc.exists;
    } catch (e, st) {
      print('checkTenant error: $e\n$st');
      return false; // أو رمي الخطأ إذا أردت أن تراه في الـ UI
    }
  }
  /// للوصول لأي collection خاصة بالتينانت
  static CollectionReference tenantCollection(
      String tenantId,
      String collection,
      ) {
    return _db
        .collection(tenantId)
        .doc(tenantId)
        .collection(collection);
  }
}