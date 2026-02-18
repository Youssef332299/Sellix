import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/Inventory/Inventory_item_model.dart';
import '../../../../../core/enum/screen_enum.dart';
import 'components/inventory_repo.dart';
import 'state.dart';

class InventoryCubit extends Cubit<InventoryState>{

  final InventoryRepository repo;
  final String companyId;

  StreamSubscription? _sub;

  List<String> sections = [];
  List<InventoryItem> items = [];

  InventoryCubit(this.repo,this.companyId)
      : super(InventoryState.init()){
    _listenItems();
  }

  void _listenItems(){
    _sub?.cancel();

    _sub = repo.getItems(companyId).listen((data){
      items = data;
      _applyFilter();
    });
  }

  void search(String value){
    emit(state.copyWith(search:value));
    _applyFilter();
  }

  void filterByStatus(InventoryStatus status){
    emit(state.copyWith(filter:status));
    _applyFilter();
  }

  void _applyFilter(){

    List<InventoryItem> result = items;

    if(state.search.isNotEmpty){
      result = result.where((e)=>
          e.name.toLowerCase()
              .contains(state.search.toLowerCase())).toList();
    }

    if(state.filter != InventoryStatus.all){
      result = result.where((e)=>
      e.status == state.filter).toList();
    }

    emit(state.copyWith(
        allItems: items,
        filteredItems: result
    ));
  }

  Future<void> addItem(InventoryItem item) async{
    await repo.addItem(companyId,item);
  }

  Future<void> updateItem(InventoryItem item) async{
    await repo.updateItem(companyId,item);
  }

  Future<void> deleteItem(String id) async{
    await repo.deleteItem(companyId,id);
  }

  @override
  Future<void> close(){
    _sub?.cancel();
    return super.close();
  }
}
