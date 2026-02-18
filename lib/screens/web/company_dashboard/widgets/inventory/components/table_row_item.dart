import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/colors/app_colors.dart';
import '../../../../../../models/Inventory/Inventory_item_model.dart';
import '../cubit.dart';
import 'add_product_dialog.dart';

class TableRowItem extends StatelessWidget {

  final InventoryItem item;

  const TableRowItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {

    final good = item.status.name == "good";

    return Row(
      children: [
        Expanded(child: Text(item.name)),
        Expanded(child: Text(item.category)),
        Expanded(
          child: Text(
            "${item.stock}",
            style: TextStyle(
              color: good
                  ? AppColors.success
                  : item.stock == 0
                  ? AppColors.error
                  : AppColors.warning,
            ),
          ),
        ),
        Expanded(child: Text("${item.min}")),
        Expanded(child: Text("${item.price}")),
        Expanded(
          child: Row(
            children: [

              /// EDIT
              IconButton(
                icon: const Icon(Icons.edit,size:18),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<InventoryCubit>(),
                      child: AddProductDialog(item: item),
                    ),
                  );
                },
              ),

              /// DELETE
              IconButton(
                icon: const Icon(Icons.delete,size:18),
                onPressed: (){
                  context.read<InventoryCubit>().deleteItem(item.id);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
