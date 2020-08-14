import 'package:flutter/material.dart';
import 'package:omi_game/engin/game.dart';
import 'package:omi_game/views/handCard.dart';
import 'package:provider/provider.dart';

class UserHand extends StatelessWidget {
  final int maxLen = 8;
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    CardGame cardGame = Provider.of<CardGame>(context);
    double width = devWidth * 0.8;
    double padding = devWidth * 0.032;
    if (cardGame.players[0].hand != null && cardGame.players[0].hand.length > 0) {
      double offset = (width / maxLen) * (8 - cardGame.players[0].hand.length) / 2;
      return Container(
        width: devWidth,
        height: (width / maxLen) * 3.6,
        alignment: Alignment.center,
        child: Stack(
          children: cardGame.players[0].hand.asMap().entries.map((entry) => Positioned(
            top: 0,
            left: padding + offset + (width / maxLen) * entry.key,
            bottom: 0,
            child: GestureDetector(
              onTap: entry.value.enable ? () {
                cardGame.selectedCard = cardGame.players[0].getCard(entry.value);
              } : null,
              child: HandCard(card: entry.value, index: entry.key,),
            ),
          )).toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}