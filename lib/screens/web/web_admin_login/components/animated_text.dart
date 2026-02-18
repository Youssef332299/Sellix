import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/core/constants/constants.dart';
import 'package:sellix/core/text/text_style.dart';

import '../../../../core/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../cubit.dart';

class AnimatedTextStart extends StatelessWidget {
  const AnimatedTextStart({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<Web_admin_loginCubit>(context);

    return AnimatedTextKit(
      totalRepeatCount: 1,
      onFinished: () => cubit.onAnimationTextEnd(context),
      animatedTexts: [
        TyperAnimatedText(
          TranslationService.tr("welcome_to_sellix"),
          speed: Duration(milliseconds: 80),
          textStyle: AppTextStyles().titlelgTlgbold,
        ),
        TyperAnimatedText(
          TranslationService.tr("security_is_our_priority_to_protect_your_business"),
          speed: Duration(milliseconds: 110),
          textStyle: AppTextStyles().titlelgTlgbold,
        ),
        TyperAnimatedText(
          TranslationService.tr("quality_and_speed_in_every_transaction"),
          speed: Duration(milliseconds: 100),
          textStyle: AppTextStyles().titlelgTlgbold,
        ),
        TyperAnimatedText(
          TranslationService.tr("f.c.a.h.e.t.m.y.s.e"),
          speed: Duration(milliseconds: 100),
          textStyle: AppTextStyles().titlelgTlgbold,
        ),
        TyperAnimatedText(
          TranslationService.tr("start_now"),
          speed: Duration(milliseconds: 60),
          textStyle: AppTextStyles().titlelgTlgbold,
        ),
      ],
    );

  }
}
