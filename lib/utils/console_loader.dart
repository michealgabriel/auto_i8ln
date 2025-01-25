import 'dart:async';
import 'dart:io';

class ConsoleLoader {
  static const List<String> _spinnerFrames = ['|', '/', '-', '\\'];
  late Timer _timer;
  int _index = 0;

  void start({String message = 'Task running...'}) {
    stdout.write('$message ');
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      stdout
          .write('\b${_spinnerFrames[_index]}'); // \b erases the last character
      _index = (_index + 1) % _spinnerFrames.length;
    });
  }

  void stop({String endMessage = ' Task completed!'}) {
    _timer.cancel();
    stdout.write('\b$endMessage\n');
  }
}
