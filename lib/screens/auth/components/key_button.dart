import 'package:flutter/material.dart';
import 'package:sellix/core/constants/constants.dart';

import '../../../core/colors/app_colors.dart';
import '../../../core/screen size/screen_size.dart';
import '../../../core/text/text_style.dart';

class KeyButton extends StatelessWidget {
  KeyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
  });

  String text;
  Color color;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onTap(),
      color: color,
      height: height(context) / 10,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: AppColors.primary500),
      ),
      splashColor: Colors.white,
      minWidth: width(context) / 4.1,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w900,fontSize: 38,fontFamily: cairoFonts)),
    );
  }
}
