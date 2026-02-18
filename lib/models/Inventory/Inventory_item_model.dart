import '../../core/enum/screen_enum.dart';

class InventoryItem {

  final String id;
  final String name;
  final String category;
  final int stock;
  final int min;
  final double price;
  final int soldCount;

  InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.stock,
    required this.min,
    required this.price, required this.soldCount,
  });

  InventoryStatus get status {
    if (stock == 0) return InventoryStatus.out;
    if (stock <= min) return InventoryStatus.low;
    return InventoryStatus.good;
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'category':category,
      'stock':stock,
      'min':min,
      'price':price,
      'soldCount':soldCount,
    };
  }

  factory InventoryItem.fromMap(String id,Map<String,dynamic> map){
    return InventoryItem(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      stock: map['stock'] ?? 0,
      min: map['min'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      soldCount: map['soldCount'] ?? '',
    );
  }
}
