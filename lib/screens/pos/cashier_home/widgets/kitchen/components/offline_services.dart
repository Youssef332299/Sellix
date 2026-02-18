import '../../../../../../models/kitchen/kitchen_model.dart';
import 'kitchen_repo.dart';

class OfflineService {

  final List<KitchenOrder> _pending=[];

  void cache(KitchenOrder order){
    _pending.add(order);
  }

  Future sync(KitchenRepo repo) async{

    for(final o in _pending){
      await repo.sendOrder(o);
    }

    _pending.clear();
  }
}
