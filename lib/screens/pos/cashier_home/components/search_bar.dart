import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/app_localization.dart';
import '../cubit.dart';

class SearchBarPOS extends StatelessWidget {
  const SearchBarPOS({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: TextField(
        cursorColor: AppColors.primary400,
        onChanged:(v)=>context.read<PosCubit>().search(v),
        style: const TextStyle(
            color:AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: TranslationService.tr("search"),
          hintStyle:const TextStyle(
              color:AppColors.textSecondary),
          filled:true,
          fillColor:AppColors.inputDark,
          prefixIcon:
          const Icon(Icons.search,
              color:AppColors.textSecondary),
          border:OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide:BorderSide.none,
          ),
        ),
      ),
    );
  }
}
