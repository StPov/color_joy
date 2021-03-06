import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'point.dart';
import 'draw_points.dart';
import 'dart:math';

class Points extends StatefulWidget {
  final int pointsCount;
  final Color pointsColor;

  Points({this.pointsCount, this.pointsColor});

  @override
  PointsState createState() => PointsState();
}

class PointsState extends State<Points> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Random random = Random();

  List<Point> pointsList = [];

  void addToPointsList() {
    for (int i = 1; i <= widget.pointsCount; i++) {
      // Added particle to particlesList
      pointsList.add(
        Point(
          color: widget.pointsColor,
          xCoordinate: random.nextDouble() * 400 + 10,
          yCoordinate: random.nextDouble() * 400 + 10,
          size: 3.0,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    addToPointsList();

    for (var particle in pointsList) {
      particle.getRandomDirection();
    }

    animationController.addListener(() {
      setState(() {
        for (var particle in this.pointsList) {
          particle.move();
        }
      });
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Point.widgetHeight = MediaQuery.of(context).size.height;
    Point.widgetWidth = MediaQuery.of(context).size.width;
    return CustomPaint(
      foregroundPainter: DisplayPoints(
        pointsList: pointsList,
      ),
    );
  }
}
