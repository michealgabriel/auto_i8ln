
import 'dart:io';
import 'package:auto_i8ln/utils/console_loader.dart';
import 'package:auto_i8ln/utils/logger_util.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logging/logging.dart';
import 'package:auto_i8ln/utils/string_constants.dart';
import 'package:auto_i8ln/src/auto_i8nl_gen.dart';


void main(List<String> args) async {

  // setup logger & console loader
  final loader = ConsoleLoader();

  LoggerUtil.configureLogger();
  final logger = LoggerUtil.logger;

  logger.info(cliToolStartMessage);

  // check args
  if (args.isEmpty) {
    logger.warning('No arguments provided!');
    printUsage(logger);
    return;
  }

  // Run >>>>>>
  final flag = args[0];
  final skipPresents = args.length > 1 && args[1] == '--skip-presents';

  // ! init - condition
  if (flag == 'init') {
    // handle directory
    final directory = Directory(generationsTargetDir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    // handle file
    final file = File('${directory.path}/auto_i8nl_gen_en.json');
    if(!file.existsSync()) 
    {
      file.writeAsStringSync(enInitContentGen);
      logger.fine('Generated ${file.path}');
    } else {
      printAlreadyInitializedMessage(logger);
      printUsage(logger);
    }
  }

  // ! translations - condition
  else if (flag == 'translations') {
    // handle directory
    final directory = Directory(generationsTargetDir);
    if (!directory.existsSync()) {
      printUninitializedMessage(logger);
      return;
    }

    // handle file
    final file = File('${directory.path}/auto_i8nl_gen_en.json');
    final enContent = file.readAsStringSync();
    if(!file.existsSync()) 
    {
      printUninitializedMessage(logger);
      return;
    } 

    logger.info(cliGenStartMessage);

    // Generative AI >>>>>>
    bool allTasksCompleted = true;
    for (var i = 1; i < autoI8lnGen.supportedLocaleNames.length; i++) // for loop start
    {
      final handlingLocale = autoI8lnGen.supportedLocales[i];
      final handlingLocaleName = autoI8lnGen.supportedLocaleNames[i];
      final localeFile = File('${directory.path}/auto_i8nl_gen_$handlingLocale.json');

      if(skipPresents) {
        if(localeFile.existsSync()) {
          logger.info('>>  🔁 Skipped $handlingLocaleName translations...');
          continue;
        }
      }

      loader.start(message: 'Generating $handlingLocaleName translations...');

final message = '''
just giving me the result without any comments or words from you, do the following: 
Maintaining the keys, translate the values into $handlingLocaleName:
$enContent
''';

      final localeContent = await generativeAI(logger, message);

      if(localeContent.isEmpty) {
        allTasksCompleted = false;
        loader.stop(endMessage: '❌ error...');  // stop the loader
        break;
      }

      localeFile.writeAsStringSync(localeContent);
      await Future.delayed(const Duration(seconds: 3)); // wait a bit before generating the next locale, to avoid overload
      loader.stop();
      logger.fine('Generated ${localeFile.path}');
    } // for loop end

    // all tasks complete flag checks
    if (allTasksCompleted) {
      logger.info('>>>>>>>>>>>>>>>>');
      logger.info('>>  All tasks completed! 🚀🔥🔥🔥');
    }
    else {
      logger.severe('>>>>>>>>>>>>>>>>');
      logger.severe('>>  Unable to complete tasks! ❌❌❌');
    }
  }

  // ! help flag - condition
  else if(args[0] == '--help') {
    printUsage(logger);
  }

  // ! invalid flag - condition
  else {
    logger.warning('Unknown flag: $flag');
  }

} // main

// Prints the usage information for the auto_i8ln:generate command
void printUsage(Logger logger) {
  logger.info('Usage: dart run auto_i8ln:generate <flag>');
  logger.info('Flags:');
  logger.info('  init: Intializes the default translation file');
  logger.info('  translations: Runs the translations generator');
}

// Prints a message when the package is not initialized
void printUninitializedMessage(Logger logger) {
  logger.severe(uninitializedMessage);
}

// Prints a message when the package is already initialized
void printAlreadyInitializedMessage(Logger logger) {
  logger.warning(alreadyInitializedMessage);
}

// Generates the translations using the generative AI
Future<String> generativeAI(Logger logger, String message) async { 
  try {  
    final apiKey = Platform.environment['GEMINI_API_KEY'];
    if (apiKey == null) {
      logger.severe(r'No $GEMINI_API_KEY environment variable');
      logger.warning('You can get your API key from: https://aistudio.google.com/app/apikey');
      logger.warning('How to set your API key to environment variables (Linux/MacOS/Windows): https://ai.google.dev/gemini-api/docs/api-key');
      logger.warning('(Windows Alternative) How to set your API key to environment variables (Windows): https://www3.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html');
      exit(1);
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
    );

    final chat = model.startChat(history: []);
    final content = Content.text(message);
    final response = await chat.sendMessage(content);
    return response.text!.replaceAll("```", "").replaceFirst("json", "");
  } 
  on GenerativeAIException catch (e) {
    logger.severe(e.message);
  } catch (_) {}

  return "";
}
