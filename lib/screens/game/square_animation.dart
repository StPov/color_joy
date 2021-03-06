import 'dart:async';
import 'dart:math';
import 'package:color_joy/helpers/logic_manager.dart';
import 'package:flutter/material.dart';
import 'package:sa_v1_migration/sa_v1_migration.dart';
import 'package:simple_animations/simple_animations.dart';
import 'square_particle.dart';
import 'package:color_joy/helpers/color_generator.dart';

class SquareAnimation extends StatefulWidget {
  @override
  _SquareAnimationState createState() => _SquareAnimationState();
}

class _SquareAnimationState extends State<SquareAnimation> {
  int _bulbIdentifier = 0;
  int _bottonRowsCount = 2;

  @override
  void initState() {
    setState(() {
      _bulbIdentifier = 2;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Game",
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 100, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Wait for the square particle and tap it",
              style: TextStyle(
                  fontFamily: 'AkayaKanadaka',
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "To win tap all square particles before new ones will appear",
              style: TextStyle(
                  fontFamily: 'AkayaKanadaka',
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  Text(
                    'Difficulty:',
                    style: TextStyle(
                        fontFamily: 'Stick',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      children: <Widget>[
                        Radio(
                            value: 2,
                            groupValue: _bulbIdentifier,
                            onChanged: (val) {
                              _bulbIdentifier = val;
                              setState(() {
                                _bottonRowsCount = 2;
                              });
                            }),
                        Text(
                          'Easy',
                          style: TextStyle(
                              fontFamily: 'Stick',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      children: <Widget>[
                        Radio(
                            value: 3,
                            groupValue: _bulbIdentifier,
                            onChanged: (val) {
                              _bulbIdentifier = val;
                              setState(() {
                                _bottonRowsCount = 3;
                              });
                            }),
                        Text(
                          'Medium',
                          style: TextStyle(
                              fontFamily: 'Stick',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      children: <Widget>[
                        Radio(
                            value: 4,
                            groupValue: _bulbIdentifier,
                            onChanged: (val) {
                              _bulbIdentifier = val;
                              setState(() {
                                _bottonRowsCount = 4;
                              });
                            }),
                        Text(
                          'Hard',
                          style: TextStyle(
                              fontFamily: 'Stick',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ColorGenerator.changeColor();
                        });
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/random.png',
                            width: 40,
                            height: 40,
                            color: Colors.white.withAlpha(400),
                          ),
                          Text(
                            'Randomize \ncolor',
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ]),
                Container(
                  color: Colors.black45,
                  height: 300,
                  width: 1,
                ),
                Column(
                  children: [
                    ...Iterable.generate(_bottonRowsCount)
                        .map((i) => rowWith2Square())
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowWith2Square() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Square(),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Square(),
        )
      ],
    );
  }
}

class Square extends StatefulWidget {
  Color _buttonColor = ColorGenerator.randomColor();

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  final List<SquareParticle> particles = [];

  bool _squaresVisible = false;

  @override
  void initState() {
    _restartSquare();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      child: _buildSquare(),
    );
  }

  Rendering _buildSquare() {
    return Rendering(
      onTick: (time) => _manageParticleLife(time),
      builder: (context, time) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (_squaresVisible)
              GestureDetector(onTap: () => _hitSquare(time), child: _square()),
            ...particles.map((it) => it.buildWidget(time))
          ],
        );
      },
    );
  }

  Widget _square() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Image.asset(
          'assets/tap.png',
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
          color: widget._buttonColor,
          shape: BoxShape.rectangle),
    );
  }

  _hitSquare(Duration time) {
    _setSquareVisible(false);
    Iterable.generate(50).forEach((i) => particles.add(SquareParticle(time)));
    if (LogicManager.checkIsAllSquaresHidden()) {
      _showMyDialog();
    }
    _restartSquare();
  }

  void _restartSquare() async {
    var respawnTime = Duration(milliseconds: 300 + Random().nextInt(3000));
    await Future.delayed(respawnTime);
    _setSquareVisible(true);
  }

  _manageParticleLife(Duration time) {
    particles.removeWhere((particle) {
      return particle.progress.progress(time) == 1;
    });
  }

  void _setSquareVisible(bool visible) {
    setState(() {
      _squaresVisible = visible;
      LogicManager.handleTap(visible);
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have tapped all squares before new ones appeared.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
