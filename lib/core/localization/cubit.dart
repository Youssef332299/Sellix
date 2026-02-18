import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localization.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(const Locale('ar')) {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString("lang") ?? "ar";

    Locale locale = Locale(lang);

    await TranslationService.load(locale);

    emit(locale);
  }

  Future<void> changeLang(String code) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("lang", code);

    Locale locale = Locale(code);

    await TranslationService.load(locale);

    emit(locale);
  }
}
