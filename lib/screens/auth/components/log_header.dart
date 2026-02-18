import 'package:flutter/material.dart';
import '../../../core/assets/images.dart';
import '../../../core/constants/constants.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            logo_backgroundDark,
            scale: 20,
          ),
          const SizedBox(width: 8),
          const Text(
            'SelliX',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: cairoFonts,
            ),
          ),
        ],
      ),
    );
  }
}
