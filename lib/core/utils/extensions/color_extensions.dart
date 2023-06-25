import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Darken color by percent (100 -> black)
  Color darkenColor([int percent = 10]) {
    assert(1 <= percent && percent <= 100);

    var f = 1 - percent / 100;
    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  /// Lighten Color by percent (100 -> white)
  Color lightenColor([int percent = 10]) {
    assert(1 <= percent && percent <= 100);

    var p = percent / 100;

    return Color.fromARGB(alpha, red + ((255 - red) * p).round(),
        green + ((255 - green) * p).round(), blue + ((255 - blue) * p).round());
  }

  /// Color to Hex
  String get toHex => '#${value.toRadixString(16)}';
}
