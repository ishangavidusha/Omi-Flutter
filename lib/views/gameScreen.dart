import 'dart:async';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omi_game/engin/game.dart';
import 'package:omi_game/models/tableCard.dart';
import 'package:omi_game/theme/appTheme.dart';
import 'package:omi_game/views/selectThurumpuView.dart';
import 'package:omi_game/views/tableCardView.dart';
import 'package:omi_game/views/userHand.dart';
import 'package:omi_game/widget/button.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  CardGame cardGame;
  bool gameStated = false;
  @override
  void initState() {
    Provider.of<CardGame>(context, listen: false).initGame();
    super.initState();
  }

  void startGame(BuildContext context) async {
    setState(() {
      gameStated = true;
    });
    cardGame.run();
    Duration duration = Duration(milliseconds: 16);
    Timer.periodic(duration, (timer) async {
      if (cardGame != null) {
        cardGame.gameUpdate();
      }
    });
  }

  Widget _getTableCard(TableCard tableCard, double boxWidth, double boxHeight) {
    double cardHeight = (boxWidth * 0.25) * 1.52;
    double cardWidth = boxWidth * 0.25;
    switch (tableCard.owner.name) {
      case 'player_0':
        return Positioned(
          top: (boxHeight * 0.5) + (cardHeight * 0.1),
          left: (boxWidth * 0.5) - (cardWidth * 0.5),
          width: cardWidth,
          child: Container(
            child: TableCardView(imagePath: tableCard.card.imagePath, direction: AnimationDirection.Up),
          ),
        );
        break;
      case 'player_1':
        return Positioned(
          top: (boxHeight * 0.5) - (cardHeight * 0.5),
          right: (boxWidth * 0.5) + (cardWidth * 0.55),
          width: boxWidth * 0.25,
          child: Container(
            child: TableCardView(imagePath: tableCard.card.imagePath, direction: AnimationDirection.Left),
          ),
        );
        break;
      case 'player_2':
        return Positioned(
          bottom: (boxHeight * 0.5) + (cardHeight * 0.1),
          left: (boxWidth * 0.5) - (cardWidth * 0.5),
          width: cardWidth,
          child: Container(
            child: TableCardView(imagePath: tableCard.card.imagePath, direction: AnimationDirection.Down),
          ),
        );
        break;
      case 'player_3':
        return Positioned(
          top: (boxHeight * 0.5) - (cardHeight * 0.5),
          left: (boxWidth * 0.5) + (cardWidth * 0.55),
          width: boxWidth * 0.25,
          child: Container(
            child: TableCardView(imagePath: tableCard.card.imagePath, direction: AnimationDirection.Right),
          ),
        );
        break;
      default:
        return Positioned(
          top: 200,
          right: 0,
          child: Container(
            child: Text('No Card'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    cardGame = Provider.of<CardGame>(context);
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
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20, 
                left: 10,
                right: 10,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.lightGreen,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Your Team',
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Keta : ${cardGame.ketaOne}',
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      cardGame.thurumpu != null ? Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Thurumpu',
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              EnumToString.parse(cardGame.thurumpu),
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ) : Container(),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Other Team',
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Keta : ${cardGame.ketaTwo}',
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: devHeight * 0.78,
            width: devWidth,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: cardGame.handResultOne != null ? cardGame.handResultOne.map((e) => SizedBox(
                      child: e == 1 ? Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'O',
                          style: AppTheme.body2.copyWith(color: Colors.transparent)
                        ),
                      ) : Container(),
                    )).toList() : []
                  ),
                  Row(
                    children: cardGame.handResultTwo != null ? cardGame.handResultTwo.map((e) => SizedBox(
                      child: e == 1 ? Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'O',
                          style: AppTheme.body2.copyWith(color: Colors.transparent)
                        ),
                      ) : Container(),
                    )).toList() : []
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: devHeight * 0.22,
            height: devHeight * 0.4,
            width: devWidth,
            child: cardGame.table != null ? Container(
              color: Colors.black12,
              child: Stack(
                children: cardGame.table.map((TableCard tableCard) => _getTableCard(tableCard, devWidth, devHeight * 0.4)).toList(),
              ),
            ) : Container(),
          ),
          Positioned(
            top: devHeight * 0.65,
            child: cardGame.showHandFineshMsg ? Container(
              width: devWidth,
              child: Text(
                cardGame.handWinnerMsg,
                style: AppTheme.headline,
                textAlign: TextAlign.center,
              ),
            ) : Container(),
          ),
          Positioned(
            bottom: devHeight * 0.1,
            child: Container(
              width: devWidth,
              child: UserHand()
            ),
          ),
          Positioned(
            bottom: devHeight * 0.1,
            left: 0,
            right: 0,
            child: gameStated != true ? Align(
              child: KButton(
                text: 'Start Game',
                onPressed: () {
                  startGame(context);
                },
              ),
            ) : Container(),
          ),
          SelectThurumpuView(),
        ],
      ),
    );
  }
}


