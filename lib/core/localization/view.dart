import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../providers/lang_cubit.dart';

class LangSwitchButton extends StatelessWidget {
  const LangSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, Locale>(
      builder: (context, locale) {
        bool isArabic = locale.languageCode == 'ar';

        return Switch(
          value: isArabic,
          onChanged: (value) {
            context
                .read<LangCubit>()
                .changeLang(value ? 'ar' : 'en');
          },
        );
      },
    );
  }
}
