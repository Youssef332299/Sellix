import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/colors/app_colors.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/screen%20size/screen_size.dart';
import 'package:sellix/core/widgets/primary_button.dart';

import '../../../../../../models/kitchen/kitchen_model.dart';
import '../cubit.dart';
import 'order_card.dart';

class SectionBoard extends StatefulWidget {
  final String section;
  final List<KitchenOrder> orders;
  final Map<String, int> timers;
  final bool historyMode;

  const SectionBoard({
    super.key,
    required this.section,
    required this.orders,
    required this.timers,
    this.historyMode = false,
  });

  @override
  State<SectionBoard> createState() => _SectionBoardState();
}

class _SectionBoardState extends State<SectionBoard> {
  final ScrollController _scrollController = ScrollController();

  void next() {
    _scrollController.animateTo(
      _scrollController.offset + 250,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previous() {
    _scrollController.animateTo(
      _scrollController.offset - 250,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KitchenCubit>();

    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          /// Header + Buttons
          Row(
            children: [
              widget.historyMode == false
                  ? SizedBox(
                width: width(context) / 1.04,
                 child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () =>Scaffold.of(context).openDrawer(), icon: Icon(Icons.format_list_bulleted_outlined)),
                          PrimaryButton(
                            onTap: previous,
                            text: TranslationService.tr('previous'),
                            color: AppColors.cardDark, width: width(context) / 5,
                          ),

                          PrimaryButton(
                            onTap: next,
                            text: TranslationService.tr('next'),
                            color: AppColors.cardDark, width: width(context) / 5,
                          ),
                          IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(CupertinoIcons.back)),

                        ],
                      ),
                  )
                  : SizedBox(),
            ],
          ),

          const SizedBox(height: 8),

          /// Orders
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.orders.length,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              scrollDirection: widget.historyMode
                  ? Axis.vertical
                  : Axis.horizontal,
              itemBuilder: (context, index) {
                final order = widget.orders[index];
                final seconds = widget.timers[order.id] ?? 0;

                return Align(
                  alignment: Alignment.topCenter,
                  child: OrderCard(
                    order: order,
                    index: index,
                    seconds: seconds,
                    small: widget.historyMode,
                    onTap: () {
                      widget.historyMode
                          ? cubit.restore(order)
                          : cubit.bump(order);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
