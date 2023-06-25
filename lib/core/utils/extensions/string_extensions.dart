import 'package:flutter/material.dart';

extension StringExtensions on String {
  /// Add Commas
  String get addCommas {
    RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formattedString = int.parse(this)
        .toStringAsFixed(0)
        .replaceAllMapped(regExp, (match) => '${match[1]},');

    return formattedString;
  }

  /// Hex String to Color
  Color get hexToColor =>
      Color(int.parse(substring(0, 6), radix: 16) + 0xFF000000);
}
