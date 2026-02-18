import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(Locale(
      WidgetsBinding.instance.window.locale.languageCode)); // لغة النظام

  /// تحميل اللغة من SharedPreferences إذا موجودة
  Future<void> loadLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('lang');
    if (langCode != null) {
      emit(Locale(langCode));
    }
  }

  /// تغيير اللغة وحفظها
  Future<void> changeLang(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', langCode);
    emit(Locale(langCode));
  }
}
