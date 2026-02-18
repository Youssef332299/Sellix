import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue.shade200,
      // margin: EdgeInsets.only(bottom: height(context) / 2 ),
      content: Text(message),
    ),
  );
}
