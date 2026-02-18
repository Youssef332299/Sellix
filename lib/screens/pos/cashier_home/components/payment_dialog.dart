import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/localization/app_localization.dart';
import '../cubit.dart';
import '../state.dart';

class PaymentDialog extends StatelessWidget {
  final double total;
  final PosCubit cubit;
  const PaymentDialog({super.key, required this.total, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<PosCubit, PosState>(
        builder: (context, state) {
          final change = state.paidAmount - total;
          return Dialog(
            backgroundColor: AppColors.cardDark,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(TranslationService.tr("payment_method"), style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Row(children: [
                    _method(context, "cash", state),
                    _method(context, "visa", state),
                    _method(context, "custom", state),
                  ]),
                  const SizedBox(height: 20),
                  Text("${TranslationService.tr("total")} : ${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  if (state.paymentMethod == "cash" || state.paymentMethod == "visa")
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [total, 200, 400, 600].map((e) {
                        return ElevatedButton(
                          onPressed: () => cubit.setPaidAmount(
                              state.paymentMethod == "cash" ? e.toDouble() : (e.toDouble() >= total ? total - 1 : e.toDouble())
                          ),
                          child: Text(e.toString()),
                        );
                      }).toList(),
                    ),
                  if (state.paymentMethod == "custom") ...[
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: TranslationService.tr("cash")),
                      onChanged: (v) => cubit.setCashPaid(double.tryParse(v) ?? 0),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: TranslationService.tr("visa")),
                      onChanged: (v) {
                        final value = double.tryParse(v) ?? 0;
                        cubit.setVisaPaid(value, total); // validation inside cubit
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  Text("${TranslationService.tr("paid")} : ${state.paidAmount.toStringAsFixed(2)}"),
                  if (change >= 0)
                    Text("${TranslationService.tr("change")} : ${change.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: TranslationService.tr("confirm_payment"),
                    onTap: () {
                      cubit.completeOrder(
                        context: context,
                        method: state.paymentMethod,
                        total: total,
                      );
                    },
                    color: AppColors.primary500,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _method(BuildContext context, String m, PosState state) {
  final cubit = context.read<PosCubit>();
  return Expanded(
    child: GestureDetector(
      onTap: () => cubit.setPaymentMethod(m),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: state.paymentMethod == m ? AppColors.primary400 : AppColors.primary600,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(m.toUpperCase(), style: const TextStyle(color: Colors.white))),
      ),
    ),
  );
}
