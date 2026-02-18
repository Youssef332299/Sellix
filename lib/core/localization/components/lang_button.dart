import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/providers/lang_cubit.dart';

class LangSwitchButton extends StatelessWidget {
  const LangSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, Locale>(
      builder: (context, locale) {
        return IconButton(
          icon: Text(
            locale.languageCode == 'ar' ? "ENGLISH" : "العربية",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            context.read<LangCubit>().changeLang(
              locale.languageCode == 'ar' ? 'en' : 'ar',
            );
          },
        );
      },
    );
  }
}
