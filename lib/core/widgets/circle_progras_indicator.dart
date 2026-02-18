import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../colors/app_colors.dart';

Widget loading() {
    return Center(
      child:   CupertinoActivityIndicator(
        radius: 32.0,
        color: Colors.blue[200],
      ),
    );
}

