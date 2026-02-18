import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../screen size/screen_size.dart';
import '../text/text_style.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    required this.width,
  });

  String text;
  Color color;
  double width;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onTap(),
      color: color,
      height: 60,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: AppColors.primary500),
      ),
      splashColor: Colors.white,
      minWidth: width,
      child: Text(text, style: AppTextStyles().bodylgBodylgbold),
    );
  }
}
