import 'dart:io';

import 'package:auto_i8ln/utils/logger_colors.dart';
import 'package:logging/logging.dart';

class LoggerUtil {
  static final Logger _logger = Logger('AutoI8LN');

  /// Configure the logger. Call this once in your package initialization.
  static void configureLogger() {
    Logger.root.level =
        Level.ALL; // Set the logging level (ALL, FINE, INFO, WARNING, SEVERE)
    Logger.root.onRecord.listen((record) {
      // final timestamp = record.time.toIso8601String();
      // final message = '[${record.level.name}] $timestamp: ${record.loggerName} - ${record.message}';
      final color = LogColors.colorForLevel(record.level);
      final message =
          '$color[${record.level.name}] ${record.message}${LogColors.reset}';
      if (record.level >= Level.SEVERE) {
        stderr.writeln(message); // Errors to stderr
      } else {
        stdout.writeln(message); // Other logs to stdout
      }
    });
  }

  /// Expose the logger for use in the package.
  static Logger get logger => _logger;
}
