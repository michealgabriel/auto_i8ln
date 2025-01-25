/// assets/auto_i8nl_generations
String generationsTargetDir = 'assets/language';

/// CLI tool start message
String cliToolStartMessage = 'Starting the CLI tool...';

/// Init english content generation
String enInitContentGen = '''
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
''';

/// CLI locale generations start message
String cliGenStartMessage = 'Starting the translations generator...';

/// Uninitialized message
String uninitializedMessage =
    'AutoI8LN uninitialized!, you can use the "init" flag to start initialize the generation';

/// Already initialized message
String alreadyInitializedMessage =
    'No need! AutoI8LN generation already initialized, you can use the "translations" flag to start the translations generator';
