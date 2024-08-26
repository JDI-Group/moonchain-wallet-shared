import 'dart:math' as math;

import 'package:flutter/material.dart';

class MXCColors {
  static String colorToHexString(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  static Color hexStringToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  static int hash(String str) {
    int hash = 0;
    for (int i = 0; i < str.length; i++) {
      hash = ((hash << 5) - hash) + str.codeUnitAt(i);
      hash &= 0xFFFFFFFF; // Convert hash to a 32-bit integer
    }
    return hash;
  }

  static Color getColorFromH3Id(String h3Id) {
    int h3Hash = hash(h3Id.toString());
    int r = (h3Hash & 0xFF0000) >> 16;
    int g = (h3Hash & 0x00FF00) >> 8;
    int b = h3Hash & 0x0000FF;
    return Color.fromARGB(255, r, g, b);
  }

  String randomColor() {
    const letters = '0123456789ABCDEF';
    String color = '#';
    for (int i = 0; i < 6; i++) {
      color += letters[(letters.length * (math.Random().nextDouble())).toInt()];
    }
    return color;
  }
}
