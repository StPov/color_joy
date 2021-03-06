import 'package:flutter/material.dart';
import 'point.dart';

class DisplayPoints extends CustomPainter {
  final List<Point> pointsList;

  DisplayPoints({
    this.pointsList,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint();
    line.strokeCap = StrokeCap.round;
    line.color = pointsList.elementAt(0).color;

    // Draw all the particles
    for (var particle in pointsList) {
      line.strokeWidth = particle.size;
      Offset center = Offset(particle.xCoordinate, particle.yCoordinate);
      line.style = PaintingStyle.fill;
      canvas.drawCircle(center, particle.size, line);
    }

    // Draw the connect line
    for (int i = 0; i < this.pointsList.length; i++) {
      for (int j = i + 1; j < this.pointsList.length; j++) {
        Point point = this.pointsList.elementAt(i);
        Point anotherPoint = this.pointsList.elementAt(j);
        if (point.isNear(anotherPoint)) {
          Offset firstParticle = Offset(point.xCoordinate, point.yCoordinate);
          Offset secondParticle =
              Offset(anotherPoint.xCoordinate, anotherPoint.yCoordinate);
          line.strokeWidth = 2.0;
          canvas.drawLine(firstParticle, secondParticle, line);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
