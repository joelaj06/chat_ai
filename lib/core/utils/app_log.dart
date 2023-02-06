import 'package:logger/logger.dart';

  Logger appLogger (Type type) => Logger(
  printer: CustomPrinter(type.toString())
);

class CustomPrinter extends LogPrinter{
  CustomPrinter(this.className);

  final String className;
  @override
  List<String> log(LogEvent event) {
   // final AnsiColor? color = PrettyPrinter.levelColors[event.level];
    final String? emoji = PrettyPrinter.levelEmojis[event.level];
    final dynamic message = event.message;

    return [('$emoji' '$className: ' '$message')];
  }
  
}