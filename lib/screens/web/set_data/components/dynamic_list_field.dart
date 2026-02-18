import 'package:flutter/material.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/localization/app_localization.dart';

class DynamicListField extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final Function(int index)? onRemove;
  final String? Function(String?)? validator;

  const DynamicListField({
    super.key,
    required this.title,
    required this.controllers,
    required this.onAdd,
    this.onRemove,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        const SizedBox(height: 10),

        ...List.generate(controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllers[index],
                    validator: validator,
                    cursorColor: AppColors.primary400,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        borderSide: BorderSide(color: AppColors.primary400),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        borderSide: BorderSide(color: AppColors.error),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        borderSide: BorderSide(color: AppColors.primary100),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (controllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.error),
                    onPressed: () => onRemove?.call(index),
                  ),
              ],
            ),
          );
        }),

        TextButton.icon(
          onPressed: onAdd,
          icon: Icon(Icons.add, color: AppColors.primary400,),
          label: Text(TranslationService.tr("add"),style: TextStyle(color: AppColors.primary400,),),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
