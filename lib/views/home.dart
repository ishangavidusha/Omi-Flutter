import 'package:flutter/material.dart';
import 'package:omi_game/theme/appTheme.dart';
import 'package:omi_game/views/gameScreen.dart';
import 'package:omi_game/widget/button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppTheme.lightGreen,
                  AppTheme.darkGreen
                ],
                radius: 1.0
              )
            ),
          ),
          Positioned(
            top: 0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: devHeight * 0.1,
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    width: devWidth,
                    height: devHeight * 0.5,
                    child: Image.asset(
                      'images/cards/aces.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  KButton(
                    text: 'PLAY',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
                    },
                  ),
                  KButton(
                    text: 'INFO',
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}