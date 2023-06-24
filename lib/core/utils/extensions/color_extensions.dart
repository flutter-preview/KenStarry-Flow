import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Darken color by percent (100 -> black)
  Color darkenColor(int percent) {
    assert(1 <= percent && percent <= 100);

    var f = 1 - percent / 100;
    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  /// Lighten Color by percent (100 -> white)

}
