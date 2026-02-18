import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit.dart';
import '../state.dart';
import '../../../../core/colors/app_colors.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {

  final ScrollController _scrollController = ScrollController();

  void _scrollNext() {
    _scrollController.animateTo(
      _scrollController.offset + 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollPrevious() {
    _scrollController.animateTo(
      _scrollController.offset - 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {

        return SizedBox(
          height: 50,
          child: Row(
            children: [

              /// زر السابق
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: _scrollPrevious,
              ),

              /// الكاتيجوريز
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: state.categories.length,
                  separatorBuilder: (c, i) => const SizedBox(width: 10),
                  itemBuilder: (c, i) {
                    final cat = state.categories[i];
                    final selected = cat == state.selectedCategory;

                    return GestureDetector(
                      onTap: () =>
                          context.read<PosCubit>().selectCategory(cat),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary500
                              : AppColors.cardDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          cat,
                          style:
                          const TextStyle(color: AppColors.textPrimary),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// زر التالي
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: _scrollNext,
              ),
            ],
          ),
        );
      },
    );
  }
}
