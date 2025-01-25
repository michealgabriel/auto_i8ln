
# Auto-I8LN: Simplify Localization in Flutter

Auto-i8ln is a powerful Flutter package designed to streamline the internationalization and localization process. It simplifies the creation of multilingual apps by automating many common localization tasks.

## Key Features

- Automated language file generation
- Seamless translation management
- Streamlined localization workflow
- Easy integration with existing Flutter projects

## Installation

Add this to your `pubspec.yaml`:
```yaml
dependencies:
  auto_i8ln: ^x.y.z
```

## Requirements

- GEMINI API Key:
AutoI8LN uses `Generative AI` to generate the language files. You can get your API key from: https://aistudio.google.com/app/apikey.
Below is a peek at how the package tunes the configuration for the API call:
```dart
generationConfig: GenerationConfig(
    temperature: 0,
    topK: 40,
    topP: 0.95,
    maxOutputTokens: 8192,
    responseMimeType: 'text/plain',
),
```
The AutoI8LN CLI would show you how to get your API key and set it in your terminal's environment variables.

## CLI Tool Usage
Using the CLI tool in your terminal, at your project root, run:
```bash
dart run auto_i8ln:generate init
```
This will generate a default (English) language file in your project's `assets/language` directory. Edit this file to add your translations by adding key-value pairs.
```json
{
  "auto_i8ln_gen_comment_1": "AutoI8ln Generated file - Use this for English translations",
  "auto_i8ln_gen_comment_2": "Other translations cannot be generated without this file",
  "auto_i8ln_gen_comment_3": "Add more key-value pairs below... (you can delete these auto_i8ln_gen_comments)",

  "HELLO_MESSAGE": "Hello, welcome to our awesome app!",
  "PLEASE_MESSAGE": "Please, provide your full name",
  "THANKS_MESSAGE": "Thank you for shopping with us!",
  "YES_MESSAGE": "Yes",
  "NO_MESSAGE": "No"
}
```

Then update your `pubspec.yaml` to include the following:
```yaml
    assets:
    - assets/language/
```

You can then use the `auto_i8ln:generate translations` command to generate the language files for auto-i8ln supported locales.
Currently, the following locales are supported:
English, French, German, Spanish, Italian
```bash
dart run auto_i8ln:generate translations
```
This will generate other language files in your project's `assets/language` directory.

Say something goes wrong while generating the language files (for example, a wifi connection issue), this means a few translations have been generated while a few have not. To fix this, you can use the `--skip-presents` flag to skip the translations that have already been generated before.
```bash
dart run auto_i8ln:generate translations --skip-presents
```
This will generate other language files in your project's `assets/language` directory, but it will skip the translations that have already been generated before.

## Basic Usage

Here's a quick example of how to use Auto-i8ln:

```dart
import 'package:auto_i8ln/auto_i8ln.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // (Optional) You can have locale from SharedPreferences for persistence
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


// In your app pages or widgets you can use the AutoText widget with its text property as the key, and the text will be translated automatically, depending on the current locale.
// The widget supports all the properties and methods of a regular Text widget.
// ....
const AutoText("HELLO_MESSAGE"),

// ....
Text.rich(
    TextSpan(
        children: [
            // For your TextSpan children, you can use AutoTextSpan just like a normal TextSpan, and add a .textSpan() to the end.
            AutoTextSpan(text: "HELLO_MESSAGE_2", style: TextStyle(fontWeight: FontWeight.bold)).textSpan(),
            // Or you could also use a regular TextSpan, and manually use the autoI8lnGen.translate() function to translate the text.
            TextSpan(text: autoI8lnGen.translate("HELLO_MESSAGE_2"), style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
    ),
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
```

## Documentation

For detailed documentation and full examples, please refer to our [GitHub repository](https://github.com/michealgabriel/auto_i8ln).

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.