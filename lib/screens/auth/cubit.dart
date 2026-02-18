import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sellix/core/localization/app_localization.dart';
import 'package:sellix/core/navigation/navigation.dart';
import 'package:sellix/core/widgets/snack_bar.dart';
import 'package:sellix/screens/pos/cashier_home/view.dart';
import '../../models/company/company_model.dart';
import '../web/company_dashboard/view.dart';
import '../../core/constants/constants.dart';
import 'state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String password = '';

  void onNumberPress(String value) {
    if (password.length >= 12) return;
    password += value;
    emit(state.copyWith());
  }

  void onDelete() {
    if (password.isEmpty) return;
    password = password.substring(0, password.length - 1);
    emit(state.copyWith());
  }

  void onClear() {
    password = '';
    emit(state.copyWith());
  }

  Future<void> onLogin(BuildContext context) async {
    if (password.isEmpty) {
      showSnackBar(context, TranslationService.tr("enter_pass"));
      return;
    }

    emit(state.copyWith(loading: true));

    try {
      final company = await _findCompany(password.trim());

      if (company == null) {
        showSnackBar(context, TranslationService.tr("validation_error"));
        emit(state.copyWith(loading: false));
        return;
      }

      _storeCompanyData(company);

      _navigateAfterLogin(context);

    } catch (e) {
      showSnackBar(context, TranslationService.tr("validation_error"));
    }

    emit(state.copyWith(loading: false));
  }

  Future<CompanyModel?> _findCompany(String input) async {

    /// 1️⃣ البحث بالـ Company ID
    final companyDoc =
    await _db.collection("companies").doc(input).get();

    if (companyDoc.exists) {
      return CompanyModel.fromFirestore(
        companyDoc.data() as Map<String, dynamic>,
        companyDoc.id,
      );
    }

    /// 2️⃣ البحث بباسورد الكاشير
    final query = await _db
        .collection("companies")
        .where(kpassCash, isEqualTo: input)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return CompanyModel.fromFirestore(
        doc.data(),
        doc.id,
      );
    }

    return null;
  }

  void _storeCompanyData(CompanyModel company) {
    companyId = company.id;
    companyName = company.name;
    companyPhones = company.phones;
    companyBranches = company.branches;
    ordersInfo = company.ordersInfo;
  }

  void _navigateAfterLogin(BuildContext context) {
    if (kIsWeb) {
      navigateAndRemoveUntilWithScale(
        context,
        CompanyDashboardPage(companyId: companyId),
      );
    } else {
      navigateAndRemoveUntilWithScale(
        context,
        PosPage(),
      );
    }
  }
}
