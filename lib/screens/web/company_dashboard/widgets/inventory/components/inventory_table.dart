import 'package:flutter/material.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../core/enum/screen_enum.dart';
import '../../../../../../core/localization/app_localization.dart';
import '../../../../../../models/Inventory/Inventory_item_model.dart';
import 'table_row_item.dart';

class InventoryTable extends StatelessWidget {

  final List<InventoryItem> items;

  const InventoryTable({super.key, required this.items});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _header(),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1),
              itemBuilder: (_, i) =>
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: TableRowItem(item: items[i]),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(){
    return Padding(
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(child: Text(TranslationService.tr("productName"))),
          Expanded(child: Text(TranslationService.tr("category"))),
          Expanded(child: Text(TranslationService.tr("quantity"))),
          Expanded(child: Text(TranslationService.tr("minStock"))),
          Expanded(child: Text(TranslationService.tr("unitPrice"))),
          Expanded(child: Text(TranslationService.tr("actions"))),
        ],
      ),
    );
  }
}
