import 'package:flutter/foundation.dart';

abstract class SideEffects {}

enum DisplayMessageType { toast, dialog, snackbar }

class DisplayMessage extends SideEffects {
  final String? message;
  final String? title;
  final DisplayMessageType type;
  final dynamic data;

  DisplayMessage({this.message, this.title, this.type = DisplayMessageType.dialog, this.data});

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, hash_and_equals
  bool operator ==(Object other) {
    return other is DisplayMessage && other.message == message && other.type == type && other.data == data;
  }
}

class CloseScreen extends SideEffects {}

class ChangeTheme extends SideEffects {}

@immutable
class NavigateScreen extends SideEffects {
  final String target;
  final Object? data;

  NavigateScreen(this.target, {this.data});

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    if (other is NavigateScreen) {
      return other.target == target && other.data == data;
    } else {
      return false;
    }
  }
}
