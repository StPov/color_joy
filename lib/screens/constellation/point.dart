import 'package:flutter/material.dart';
import 'dart:math';

class Point {
  final Color color;
  double xCoordinate;
  double yCoordinate;
  final double size;
  double xDirection;
  double yDirection;
  static double widgetWidth;
  static double widgetHeight;
  static double connectDistance = 100.0;
  static double speedUp = 2.5;
  Random random = Random();

  Point({
    this.color,
    this.xCoordinate,
    this.yCoordinate,
    this.size,
  });

  bool isNear(Point anotherParticle) {
    // Calculate the distance between two points
    double distance = (this.xCoordinate - anotherParticle.xCoordinate) *
            (this.xCoordinate - anotherParticle.xCoordinate) +
        (this.yCoordinate - anotherParticle.yCoordinate) *
            (this.yCoordinate - anotherParticle.yCoordinate);

    if (sqrt(distance) <= connectDistance) {
      return true;
    }
    return false;
  }

  void getRandomDirection() {
    xDirection = random.nextDouble() * speedUp;
    yDirection = random.nextDouble() * speedUp;
  }

  void move() {
    // Make the point bounce when it reaches the borders
    if (this.xCoordinate + this.xDirection > Point.widgetWidth ||
        this.xCoordinate + this.xDirection < 0) {
      this.xDirection = this.xDirection * (-1);
    }
    if (this.yCoordinate + this.yDirection > Point.widgetHeight ||
        this.yCoordinate + this.yDirection < 0) {
      this.yDirection = this.yDirection * (-1);
    }
    this.xCoordinate += this.xDirection;
    this.yCoordinate += this.yDirection;
  }
}
