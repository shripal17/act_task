import 'package:flutter/material.dart';

extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => mediaQuery.size.width;

  double get screenHeight => mediaQuery.size.height;
}

extension StringX on String {
  String get readableFromCamelCase {
    String readable = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i].toUpperCase() == this[i]) {
        readable += " " + this[i];
      } else {
        readable += this[i];
      }
    }
    return readable;
  }
}
