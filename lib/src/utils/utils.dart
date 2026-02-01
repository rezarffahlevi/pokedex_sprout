import 'dart:developer';

import 'package:flutter/material.dart';

class Utils {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> addDelay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds), () {});
  }

  static Future<void> addDelayInMS(int t) async {
    await Future.delayed(Duration(milliseconds: t), () {});
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
