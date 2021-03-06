import 'package:color_joy/helpers/color_generator.dart';
import 'package:flutter/material.dart';
import 'points.dart';

class Constellation extends StatefulWidget {
  @override
  _ConstellationState createState() => _ConstellationState();
}

class _ConstellationState extends State<Constellation> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Constellation",
        ),
      ),
      // backgroundColor: ColorGenerator.randomColor(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            ColorGenerator.changeColor();
          });
        },
        child: Container(
          color: ColorGenerator.randomColor(),
          child: Stack(children: <Widget>[
            Points(pointsCount: 30, pointsColor: Colors.blue),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Hey there",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: Colors.black12),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: Colors.black12),
                          Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.black12),
                          Shadow(
                              // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: Colors.black12),
                        ]),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
