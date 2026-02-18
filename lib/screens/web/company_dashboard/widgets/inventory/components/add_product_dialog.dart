import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/localization/app_localization.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../../models/Inventory/Inventory_item_model.dart';
import '../cubit.dart';

class AddProductDialog extends StatefulWidget {

  final InventoryItem? item;

  const AddProductDialog({super.key,this.item});

  @override
  State<AddProductDialog> createState()
  => _AddProductDialogState();
}

class _AddProductDialogState
    extends State<AddProductDialog>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scale;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController category;
  late TextEditingController stock;
  late TextEditingController min;
  late TextEditingController price;

  @override
  void initState() {

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    scale = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    controller.forward();

    name = TextEditingController(text: widget.item?.name ?? "");
    category = TextEditingController(text: widget.item?.category ?? "");
    stock = TextEditingController(
        text: widget.item?.stock.toString() ?? "");
    min = TextEditingController(
        text: widget.item?.min.toString() ?? "");
    price = TextEditingController(
        text: widget.item?.price.toString() ?? "");

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    name.dispose();
    category.dispose();
    stock.dispose();
    min.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<InventoryCubit>();
    final isEdit = widget.item != null;

    return ScaleTransition(
      scale: scale,
      child: AlertDialog(
        backgroundColor: AppColors.primary700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
            isEdit
                ? TranslationService.tr("edit_product")
                : TranslationService.tr("add_product")
        ),
        content: SizedBox(
          width: 420,
          child: Form(
            key: _formKey,
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                _field(
                    TranslationService.tr("product_name"),
                    name),

                _field(
                    TranslationService.tr("category"),
                    category),

                _field(
                    TranslationService.tr("stock"),
                    stock,
                    isNumber:true),

                _field(
                    TranslationService.tr("min_stock"),
                    min,
                    isNumber:true),

                _field(
                    TranslationService.tr("price"),
                    price,
                    isNumber:true,
                    isDouble:true),
              ],
            ),
          ),
        ),
        actions: [

          TextButton(
            onPressed: ()=>Navigator.pop(context),
            child: Text(TranslationService.tr("cancel")),
          ),

          ElevatedButton(
            onPressed: (){

              if(!_formKey.currentState!.validate()) return;

              final item = InventoryItem(
                id: widget.item?.id ?? "",
                name: name.text,
                category: category.text,
                stock: int.parse(stock.text),
                min: int.parse(min.text),
                price: double.parse(price.text),
                soldCount: int.parse(min.text),
              );

              if(isEdit){
                cubit.updateItem(item);
              }else{
                cubit.addItem(item);
              }

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary400,
            ),
            child: Text(
                isEdit
                    ? TranslationService.tr("update")
                    : TranslationService.tr("add")),
          )
        ],
      ),
    );
  }

  Widget _field(
      String hint,
      TextEditingController c,
      {bool isNumber=false,
        bool isDouble=false}){

    return Padding(
      padding: const EdgeInsets.only(bottom:12),
      child: TextFormField(
        controller:c,
        keyboardType:
        isNumber
            ? TextInputType.numberWithOptions(
            decimal:isDouble)
            : TextInputType.text,

        inputFormatters: isNumber
            ? [
          FilteringTextInputFormatter.allow(
              RegExp(isDouble
                  ? r'^\d*\.?\d*$'
                  : r'^\d*$'))
        ]
            : null,

        validator:(v){

          if(v==null || v.isEmpty){
            return TranslationService.tr("required");
          }

          if(isNumber){

            final n =
            isDouble
                ? double.tryParse(v)
                : int.tryParse(v);

            if(n==null){
              return TranslationService.tr("invalid_number");
            }

            if(n<=0){
              return TranslationService.tr("must_be_positive");
            }
          }

          return null;
        },

        decoration: InputDecoration(
          hintText: hint,
          filled:true,
          fillColor: const Color(0xFF0F172A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
