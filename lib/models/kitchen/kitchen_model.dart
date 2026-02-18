import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class KitchenOrder extends Equatable {
  final String id;
  final String table;
  final String seat;
  final String section;
  final int priority;
  final Timestamp time;
  final String status;
  final bool changed;
  final List<Map<String,dynamic>> items;
  final String orderType; // Pickup, Dine In, Drive Thru
  final String? deliveryTable; // فقط لـ Dine In

  const KitchenOrder({
    required this.id,
    required this.table,
    required this.seat,
    required this.section,
    required this.priority,
    required this.time,
    required this.status,
    required this.items,
    required this.orderType,
    this.deliveryTable,
    this.changed = false,
  });

  factory KitchenOrder.fromJson(Map<String,dynamic> json){
    return KitchenOrder(
      id: json['id'],
      table: json['table'],
      seat: json['seat'],
      section: json['section'],
      priority: json['priority'] ?? 1,
      time: json['time'],
      status: json['status'] ?? "pending",
      changed: json['changed'] ?? false,
      items: List<Map<String,dynamic>>.from(json['items'] ?? []),
      orderType: json['orderType'] ?? "Pickup",
      deliveryTable: json['deliveryTable'],
    );
  }

  Map<String,dynamic> toJson()=> {
    "id":id,
    "table":table,
    "seat":seat,
    "section":section,
    "priority":priority,
    "time":time,
    "status":status,
    "changed":changed,
    "items":items,
    "orderType":orderType,
    "deliveryTable":deliveryTable,
  };

  @override
  List<Object?> get props => [id,status,priority,changed,orderType,deliveryTable];
}
