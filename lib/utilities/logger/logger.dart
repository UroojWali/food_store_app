import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
  // Use the default LogFilter (-> only log in debug mode) below is the default filter
  filter: DevelopmentFilter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
