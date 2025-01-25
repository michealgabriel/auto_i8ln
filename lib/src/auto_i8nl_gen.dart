import 'dart:convert';
import 'package:auto_i8ln/utils/string_constants.dart';

AutoI8lnGen autoI8lnGen = AutoI8lnGen();

class AutoI8lnGen {
  // ! Vars
  /// Current locale
  String locale = 'en';

  /// Current locale data
  dynamic localeJsonData;

  /// English: en || French: fr || German: de || Spanish: es || Italian: it
  List<String> supportedLocales = ['en', 'fr', 'de', 'es', 'it'];

  /// English || French || German || Spanish || Italian
  List<String> supportedLocaleNames = [
    'English',
    'French',
    'German',
    'Spanish',
    'Italian'
  ];

  // ! Methods
  /// Sets the locale to be used, default locale is 'en' if not set or no param is passed
  void setLocale(String? localeValue) {
    if (localeValue == null) return;
    locale = supportedLocales.firstWhere(
        (e) => e.toLowerCase() == localeValue.toLowerCase(),
        orElse: () => supportedLocales[0]);
  }

  /// Initializes the locale with the given content
  void initializeLocale(String localeContent) {
    localeJsonData = json.decode(localeContent);
  }

  /// Returns the path to the generated locale file
  String getGenPath() {
    return '$generationsTargetDir/auto_i8nl_gen_$locale.json';
  }

  /// Returns the ISO code for the given locale name
  String getLocaleISOByName(String localeName) {
    return autoI8lnGen
        .supportedLocales[autoI8lnGen.supportedLocaleNames.indexOf(localeName)];
  }

  /// Translates the given key
  String translate(String key) {
    if (localeJsonData == null) return '❌$key';
    return localeJsonData[key] ??
        '❌$key'; // Fallback to the key if no translation is found
  }

  /// Live translates the given key
  // String liveTranslate(String key) {
  //   return key;
  // }
}
