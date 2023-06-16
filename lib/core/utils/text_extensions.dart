import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextExtensions on Text {

  /// Add Gradient
  ShaderMask get addGradient {
    //  my gradient
    const gradient = LinearGradient(colors: [Colors.white, Colors.lightBlueAccent]);

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: this,
    );
  }
}
