import 'package:flutter/material.dart';

enum LanguageCode {
  en,
  ne,
}

class LangugageProvider extends ChangeNotifier {
  LanguageCode _language = LanguageCode.en;

  LanguageCode get getLanguage => _language;

  set setLanguage(LanguageCode lang) {
    _language = lang;
    notifyListeners();
  }
}
