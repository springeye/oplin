import 'dart:developer' as developer;

final appLog = Logger("Notebook");

class Logger {
  final String tag;

  Logger(this.tag);

  void debug(String message) {
    developer.log(message, name: tag, level: 100, time: DateTime.now());
  }
}
