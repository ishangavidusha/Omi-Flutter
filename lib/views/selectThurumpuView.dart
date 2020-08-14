import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:omi_game/engin/game.dart';
import 'package:omi_game/models/card.dart';
import 'package:omi_game/theme/appTheme.dart';
import 'package:provider/provider.dart';

class SelectThurumpuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    CardGame cardGame = Provider.of<CardGame>(context);
    return cardGame.waitForThurumpu ? Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: devHeight * 0.4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    cardGame.thurumpu = CardSuit.Clubs;
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: devWidth * 0.2,
                    height: devHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      EnumToString.parse(CardSuit.Clubs),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cardGame.thurumpu = CardSuit.Diamonds;
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: devWidth * 0.2,
                    height: devHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      EnumToString.parse(CardSuit.Diamonds),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cardGame.thurumpu = CardSuit.Hearts;
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: devWidth * 0.2,
                    height: devHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      EnumToString.parse(CardSuit.Hearts),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cardGame.thurumpu = CardSuit.Spades;
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: devWidth * 0.2,
                    height: devHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      EnumToString.parse(CardSuit.Spades),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Select Thurumpu',
                style: AppTheme.headline,
              ),
            ),
          ],
        ),
      ),
    ) : Container();
  }
}