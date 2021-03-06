import 'dart:math';
import 'package:flutter/material.dart';

class ColorGenerator {
  static int _redShade = 100;
  static int _greenShade = 100;
  static int _blueShade = 100;
  static double _opacity = 1.0;

  static void changeColor() {
    _redShade = Random().nextInt(255);
    _greenShade = Random().nextInt(255);
    _blueShade = Random().nextInt(255);
    _opacity = Random().nextDouble();
  }

  static Color randomColor() {
    return Color.fromRGBO(_redShade, _greenShade, _blueShade, _opacity);
  }
}
