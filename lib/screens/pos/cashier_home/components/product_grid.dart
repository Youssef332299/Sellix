import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';
import '../cubit.dart';
import '../state.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PosCubit,PosState>(
      builder:(context,state){

        final list = state.filtered;

        if(list.isEmpty){
          return Center(
            child: Text(TranslationService.tr("no_have_products")),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(15),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 14,
            mainAxisSpacing:13,
          ),
          itemCount:list.length,
          itemBuilder:(c,i){

            final item = list[i];

            return ProductCard(
              item:item,
              onTap:()=>context
                  .read<PosCubit>()
                  .addToCart(item),
            );
          },
        );
      },
    );
  }
}
