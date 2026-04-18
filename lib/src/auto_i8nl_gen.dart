import 'dart:convert';
import 'package:auto_i8ln/utils/string_constants.dart';

AutoI8lnGen autoI8lnGen = AutoI8lnGen();

class AutoI8lnGen {
  // ! Vars
  /// Current locale
  String locale = 'en';

  /// Current locale data
  dynamic localeJsonData;

  /// Debug mode status
  bool debugMode = false;

  List<String> supportedLocales = ['en'];
  List<String> supportedLocaleNames = ['English'];
  String fallbackLocale = 'en';

  // ! Methods
  /// Set the supported locales dynamically from your app code
  void configLocales(Map<String, String> locales, {String fallbackLocale = 'en'}) {
    supportedLocales = locales.keys.toList();
    supportedLocaleNames = locales.values.toList();
    this.fallbackLocale = fallbackLocale;
  }

  /// Sets the locale to be used, default locale is 'en' if not set or no param is passed
  void setLocale(String? localeValue) {
    if (localeValue == null) return;
    locale = supportedLocales.firstWhere(
        (e) => e.toLowerCase() == localeValue.toLowerCase(),
        orElse: () => fallbackLocale);
  }

  /// Initializes the locale with the given content
  /// | debugModeFlag: Enables debug mode (this helps to identify missing keys as it marks them with a ❌ in your UI)
  void initializeLocale(String localeContent, {bool debugModeFlag = false}) {
    debugMode = debugModeFlag;
    localeJsonData = json.decode(localeContent);
  }

  /// Returns the path to the generated locale file
  String getGenPath() {
    return '$generationsTargetDir/auto_i8nl_gen_$locale.json';
  }

  /// Returns the ISO code for the given locale name
  String getLocaleISOByName(String localeName) {
    final idx = autoI8lnGen.supportedLocaleNames.indexOf(localeName);
    if (idx != -1) {
      return autoI8lnGen.supportedLocales[idx];
    }
    return fallbackLocale;
  }

  /// Translates the given key
  String translate(String key) {
    bool encounteredUnknownKey = false;
    String stringCompile = '';
    String xAppend = '';
    if (debugMode) {
      xAppend = '❌';
    }

    if (localeJsonData == null) return '$xAppend $key';

    // split the key string by space and loop through each word
    key.split(' ').forEach((word) {
      if (localeJsonData.containsKey(word)) {
        stringCompile += '${localeJsonData[word]} ';
      } else {
        encounteredUnknownKey = true;
        stringCompile += '$word ';
      }
    });

    return encounteredUnknownKey ? '$xAppend $stringCompile' : stringCompile;
  }

  /// Live translates the given key
  // String liveTranslate(String key) {
  //   return key;
  // }
}
