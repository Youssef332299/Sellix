import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TranslationService {
  static Map<String, String> _localizedStrings = {};

  /// تحميل اللغة
  static Future<void> load(Locale locale) async {
    // تحديث المسار ليكون داخل lib/core/localization/l10n
    String path = 'assets/lang/${locale.languageCode}.json';
    String jsonString = await rootBundle.loadString(path);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  /// ترجمة المفتاح
  static String tr(String key) {
    return _localizedStrings[key] ?? key;
  }
}

/// دالة مختصرة للوصول للترجمة بسهولة
String tr(String key) => TranslationService.tr(key);
