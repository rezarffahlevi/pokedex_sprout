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

  static String formatHeightPokedex(int? heightDm) {
    final meter = (heightDm ?? 0) / 10;
    final totalInches = meter * 39.3701;

    final feet = totalInches ~/ 12;
    final inches = (totalInches % 12).round();

    return "${feet}′${inches}″ (${meter.toStringAsFixed(2)} m)";
  }

  static String formatWeightPokedex(int? weightHg) {
    final kg = (weightHg ?? 0) / 10;
    final lbs = kg * 2.20462;

    return "${lbs.toStringAsFixed(1)} lbs (${kg.toStringAsFixed(1)} kg)";
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
