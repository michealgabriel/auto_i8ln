import 'package:logging/logging.dart';

class LogColors {
  static const String reset = '\x1B[0m';
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  static String colorForLevel(Level level) {
    switch (level) {
      case Level.SEVERE:
        return red; // Red for severe logs
      case Level.WARNING:
        return yellow; // Yellow for warnings
      case Level.INFO:
        return blue; // Blue for informational logs
      case Level.FINE:
      case Level.FINER:
      case Level.FINEST:
        return green; // Green for fine-grained logs
      default:
        return white; // Default to white
    }
  }
}
