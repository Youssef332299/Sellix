import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sellix/core/widgets/primary_button.dart';
import 'package:sellix/screens/pos/cashier_home/components/payment_dialog.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../core/screen size/screen_size.dart';
import '../cubit.dart';
import '../state.dart';
import 'invoice_service.dart';

class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
      ),
      child: BlocBuilder<PosCubit, PosState>(
        builder: (context, state) {
          final cubit = context.read<PosCubit>();

          double subtotal = 0;
          for (final i in state.cart) {
            subtotal += i['price'] * i['qty'];
          }

          final tax = subtotal * 0.15;
          final total = subtotal + tax;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      CupertinoIcons.shopping_cart,
                      color: AppColors.primary400,
                      size: 30,
                    ),
                  ),
                  Text(
                    TranslationService.tr('cart'),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: state.orderType,
                    dropdownColor: AppColors.cardDark,
                    style: const TextStyle(color: AppColors.textPrimary),
                    underline: Container(),
                    items: ['Pickup', 'Dine In', 'Drive Thru']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        cubit.setOrderType(v);
                        if (v == "Dine In") {
                          _showTableSelection(context);
                        }
                      }
                    },
                  ),
                  Text(state.cart.length.toString()),
                  const SizedBox(width: 5),
                  Text(TranslationService.tr("items")),
                ],
              ),
              Row(
                children: [
                ],
              ),

              const Divider(),

              /// المنتجات
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (c, i) {
                    final item = state.cart[i];
                    return GestureDetector(
                      onTap: () => _showNoteDialog(context, item),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.inputDark,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              thickness: 2,
                              color: item['state']
                                  ? AppColors.primary500
                                  : AppColors.error,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                ),                                Text(
                                  "${item['price']}",
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.textMuted,
                                  ),
                                  onPressed: () =>
                                      cubit.removeFromCart(item['id']),
                                ),
                              ],
                            ),

                            if (item['note'] != null &&
                                item['note'].toString().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  "${item['note']}",
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("EGP ${item['price'] * item['qty']}"),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => cubit.addItem(item),
                                      icon: const Icon(LucideIcons.plus),
                                    ),
                                    Text('${item['qty']}'),
                                    IconButton(
                                      onPressed: () => cubit.removeItem(item),
                                      icon: const Icon(LucideIcons.minus),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Divider(),

              _row("Subtotal", subtotal),
              _row("Tax", tax),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "EGP ${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 22,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryButton(
                    onTap: () {
                      InvoiceService().printInvoice(
                        cart: state.cart,
                        subtotal: subtotal,
                        tax: tax,
                        total: total,
                        orderType: state.orderType,
                        tableNumber: state.deliveryTable,
                      );
                    },
                    text: TranslationService.tr('print'),
                    color: AppColors.primary200,
                    width: width(context) / 14,
                  ),

                  PrimaryButton(
                    onTap: () {
                      final cubit = context.read<PosCubit>();

                      cubit.setPaidAmount(total);

                      showDialog(
                        context: context,
                        builder: (_) => PaymentDialog(
                          total: total,
                          cubit: cubit, // 👈 مهم جداً
                        ),
                      );
                    },
                    text: TranslationService.tr('checkout'),
                    color: AppColors.primary500,
                    width: width(context) / 7,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _row(String t, double v) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(color: AppColors.textSecondary)),
          Text(
            "EGP ${v.toStringAsFixed(2)}",
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

void _showTableSelection(BuildContext context) {
  final cubit = context.read<PosCubit>();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(TranslationService.tr("select_table")),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 50,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              final tableNum = "T${index + 1}";
              return GestureDetector(
                onTap: () {
                  cubit.selectDeliveryTable(tableNum);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: cubit.state.deliveryTable == tableNum
                        ? AppColors.primary400
                        : AppColors.primary600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tableNum,
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

void _showNoteDialog(BuildContext context, Map item) {
  final controller = TextEditingController(text: item['note'] ?? "");

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: AppColors.cardDark,
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: TranslationService.tr("note")),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<PosCubit>().addNote(item['id'], controller.text);
              Navigator.pop(context);
            },
            child: Text(TranslationService.tr("save")),
          ),
        ],
      );
    },
  );
}
