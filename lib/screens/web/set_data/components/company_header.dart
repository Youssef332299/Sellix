import 'package:flutter/cupertino.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/text/text_style.dart';

class CompanyHeader extends StatelessWidget {
  const CompanyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      TranslationService.tr("company_setup"),
      style: AppTextStyles().titlelgTlgbold,
    );
  }
}
