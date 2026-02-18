import 'package:flutter/material.dart';

import '../../../../core/widgets/app_text_field.dart';

class EmployeeIdField extends StatelessWidget {
  final TextEditingController controller;

  const EmployeeIdField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: 'Employee ID',
    );
  }
}
