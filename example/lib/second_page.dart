import 'package:auto_i8ln/auto_i8ln.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  handleLocaleChange(String locale) async {
    autoI8lnGen.setLocale(locale);
    final content = await rootBundle.loadString(autoI8lnGen.getGenPath());
    autoI8lnGen.initializeLocale(content);
    // You can save locale to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auto_i8ln_locale', locale);

    // Show restart dialog
    if (mounted) {
      await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: AutoText('DIALOG_LOCALE_CHANGED_TITLE'),
            content: AutoText('DIALOG_LOCALE_CHANGED_MESSAGE'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoText("SECOND_PAGE_TITLE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AutoText("SECOND_PAGE_MESSAGE"),
            const SizedBox(
              height: 60,
            ),
            const AutoText(
              "APP_SETTINGS_TITLE_MESSAGE",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                hint: const AutoText("SELECT_LANGUAGE_MESSAGE"),
                items: autoI8lnGen.supportedLocaleNames
                    .map((localeName) => DropdownMenuItem(
                          value: autoI8lnGen.getLocaleISOByName(localeName),
                          child: Text(localeName),
                        ))
                    .toList(),
                onChanged: (value) => handleLocaleChange(value!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
