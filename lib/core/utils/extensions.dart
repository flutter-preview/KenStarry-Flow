import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension AddGradientToText on Text {
  ShaderMask get addGradient {
    //  my gradient
    const gradient = LinearGradient(colors: [Colors.red, Colors.blue]);

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: this,
    );
  }
}
