import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../screen size/screen_size.dart';
import '../text/text_style.dart';

class TextIconButton extends StatelessWidget {
  TextIconButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    required this.icon,
  });

  String text;
  Color color;
  IconData icon;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onTap(),
      color: color,
      height: 70,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: AppColors.primary500),
      ),
      splashColor: Colors.white,
      minWidth: width(context) / 11,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,size: 36,),
          SizedBox(height: 5,),
          Text(text, style: AppTextStyles().bodylgBodylgbold),
        ],
      ),
    );
  }
}
