import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/constants.dart';
import '../../../core/localization/app_localization.dart';
import 'state.dart';

class SetDataCubit extends Cubit<SetDataState> {
  SetDataCubit() : super(SetDataInitial());

  List<TextEditingController> phones = [TextEditingController()];
  List<TextEditingController> complaints = [TextEditingController()];
  List<TextEditingController> branches = [TextEditingController()];
  bool newClient = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPhone() {
    phones.add(TextEditingController());
    emit(SetDataRefresh());
  }

  void removePhone(int index) {
    if (phones.length > 1) {
      phones.removeAt(index);
      emit(SetDataRefresh());
    }
  }

  void addComplaint() {
    complaints.add(TextEditingController());
    emit(SetDataRefresh());
  }

  void removeComplaint(int index) {
    if (complaints.length > 1) {
      complaints.removeAt(index);
      emit(SetDataRefresh());
    }
  }

  void addBranch() {
    branches.add(TextEditingController());
    emit(SetDataRefresh());
  }

  void removeBranch(int index) {
    if (branches.isNotEmpty) {
      branches.removeAt(index);
      emit(SetDataRefresh());
    }
  }

  String generateCompanyId() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<void> saveCompany({
    required String name,
    required String password,
    required String about,
    required List<String> phones,
    required List<String> complaints,
    required List<String> branches,
    required String ordersInfo,
  }) async {
    if (password.length != 6 || !RegExp(r'^\d{6}$').hasMatch(password)) {
      emit(SetDataError("كلمة المرور يجب أن تكون 6 أرقام"));
      return;
    }

    emit(SetDataLoading());

    try {
      String companyId = generateCompanyId();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await firestore.collection("companies").doc(companyId).set({
        "name": name,
        kpassCash: password,
        // kpassCash: int.parse(password),
        "about": about,
        "phones": phones,
        "complaintsPhones": complaints,
        "branches": branches,
        "ordersInfo": ordersInfo,
        "createdAt": Timestamp.now(),
      });
      sharedPreferences.setBool("first_time", false);

      emit(SetDataSuccess(companyId));
    } catch (e) {
      emit(SetDataError(e.toString()));
    }
  }

  List<String> getValues(List<TextEditingController> list) {
    return list.map((e) => e.text).where((e) => e.isNotEmpty).toList();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TranslationService.tr("required_field");
    }
    if (value.length < 3 || value.length > 40) {
      return TranslationService.tr("invalid_length");
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length != 6) {
      return TranslationService.tr("invalid_password");
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TranslationService.tr("required_field");
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return TranslationService.tr("numbers_only");
    }
    if(value.length < 11 || value.length > 13){
      return TranslationService.tr("required_field");
    }
    return null;
  }
}
