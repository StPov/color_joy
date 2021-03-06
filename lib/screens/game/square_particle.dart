import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:color_joy/helpers/color_generator.dart';

class SquareParticle {
  Animatable tween;
  AnimationProgress progress;

  SquareParticle(Duration time) {
    final random = Random();
    final x = (100 + 200) * random.nextDouble() * (random.nextBool() ? 1 : -1);
    final y = (100 + 200) * random.nextDouble() * (random.nextBool() ? 1 : -1);

    tween = MultiTrackTween([
      Track("x").add(Duration(seconds: 1), Tween(begin: 0.0, end: x)),
      Track("y").add(Duration(seconds: 1), Tween(begin: 0.0, end: y)),
      Track("scale").add(Duration(seconds: 1), Tween(begin: 1.0, end: 0.0))
    ]);
    progress = AnimationProgress(
        startTime: time, duration: Duration(milliseconds: 1200));
  }

  buildWidget(Duration time) {
    final animation = tween.transform(progress.progress(time));
    return Positioned(
      left: animation["x"],
      top: animation["y"],
      child: Transform.scale(
        scale: animation["scale"],
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: ColorGenerator.randomColor(), shape: BoxShape.circle),
        ),
      ),
    );
  }
}
