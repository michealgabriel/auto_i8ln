
import 'package:auto_i8ln/auto_i8ln.dart';
import 'package:example/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // You can have locale from SharedPreferences for persistence
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString('auto_i8ln_locale');

    // ! IMPORTANT: Set locale first
    autoI8lnGen.setLocale(locale);
    // ! NEXT: Initialize locale
    final content = await rootBundle.loadString(autoI8lnGen.getGenPath());
    autoI8lnGen.initializeLocale(content);
  } catch(_) {}

  // Run the app
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto I8LN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}


// Demo Page
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  handleLocaleChange(String locale) async {
    autoI8lnGen.setLocale(locale);
    final content = await rootBundle.loadString(autoI8lnGen.getGenPath());
    autoI8lnGen.initializeLocale(content);
    // You can save locale to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auto_i8ln_locale', locale);

    // Show restart dialog
    if(mounted) {
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
        title: const Text('Auto I8LN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60,),

            const AutoText("HELLO_MESSAGE"),
            const SizedBox(height: 40,),
            const AutoText("HELLO_MESSAGE_2"),
            const SizedBox(height: 40,),
            const AutoText("ONE_MORE_MESSAGE"),
            const SizedBox(height: 40,),

            Text.rich(
              TextSpan(
                children: [
                  // autoI8lnGen.textSpan(text: "HELLO_MESSAGE_3", style: const TextStyle(fontWeight: FontWeight.bold)),
                  AutoTextSpan(text: "HELLO_MESSAGE_2", style: TextStyle(fontWeight: FontWeight.bold)).textSpan(),
                  TextSpan(text: autoI8lnGen.translate("HELLO_MESSAGE_2"), style: const TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SecondPage())
                );
              },
              child: const AutoText("NAV_SECOND_PAGE_BTN_MESSAGE"),
            ),

            const SizedBox(height: 60,),

            const AutoText("APP_SETTINGS_TITLE_MESSAGE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            const SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                hint: const AutoText("SELECT_LANGUAGE_MESSAGE"),
                items: autoI8lnGen.supportedLocaleNames.map((localeName) => DropdownMenuItem(
                  value: autoI8lnGen.getLocaleISOByName(localeName),
                  child: Text(localeName),
                )).toList(),
                onChanged: (value) => handleLocaleChange(value!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
