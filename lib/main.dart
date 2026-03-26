import 'dart:async';

import 'package:ecommerce/ui/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/logging.dart';
import 'inject/injector.dart';

void main() async {
  runZonedGuarded(() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    WidgetsFlutterBinding.ensureInitialized();

    Injector.setUp();

    runApp(const HomeScreen());
  }, (Object error, StackTrace stackTrace) {
    ///Print log issues in console while app is in development
    if (error == 'No Internet Connection') {
      return;
    }
    kDebugMode ? printLog(message: 'Error: $error \n StackTrace: $stackTrace') : null;

    ///Report issues to firebase when not in development
  });
}
