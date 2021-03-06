import 'package:color_joy/screens/bubbles/bubbles.dart';
import 'package:color_joy/screens/constellation/constellation.dart';
import 'package:color_joy/screens/game/square_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Joy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ColorJoy(),
    );
  }
}

class ColorJoy extends StatefulWidget {
  @override
  _ColorJoyState createState() => _ColorJoyState();
}

class _ColorJoyState extends State<ColorJoy> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Constellation();
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        child: Icon(Icons.videogame_asset),
        backgroundColor: Colors.orange,
        onPressed: () {
          currentScreen = SquareAnimation();
          setBottomBarIndex(1);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo.shade900,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.nights_stay,
                      color: currentIndex == 0
                          ? Colors.orange
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(0);
                      currentScreen = Constellation();
                    }),
                SizedBox.shrink(),
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.bubble_chart,
                      color: currentIndex == 2
                          ? Colors.orange
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(2);
                      currentScreen = Bubbles();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
