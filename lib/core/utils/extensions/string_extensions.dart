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
  get toColor {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
