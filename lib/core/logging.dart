import 'package:logger/logger.dart';

final _logger = Logger(filter: DevelopmentFilter(), printer: PrettyPrinter(printEmojis: true));

void printLog({dynamic message, dynamic error, StackTrace? stackTrace}) => error == null
    ? _logger.d(message, time: DateTime.now())
    : _logger.e(message, error: error, stackTrace: stackTrace, time: DateTime.now());
