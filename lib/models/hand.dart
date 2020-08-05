import 'package:flutter/cupertino.dart';
import 'package:omi_game/models/card.dart';
import 'package:omi_game/theme/appTheme.dart';

class Hand {
  List<Card> cards;

  Hand({
    this.cards
  });

  addCards(Card card) {
    this.cards.add(card);
  }

  Card getCard(Card card) {
    this.cards.removeWhere((element) => element.rank == card.rank && element.suit == card.suit);
    return card;
  }

  Widget viewHand(double width, Function onTap) {
    int maxLen = 8;
    if (this.cards != null && this.cards.length > 0) {
      return Container(
        width: width,
        height: (width / maxLen) * 1.53,
        child: Stack(
          children: this.cards.asMap().entries.map((entry) => Positioned(
            top: 0,
            left: (width / maxLen) * entry.key,
            bottom: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Image.asset(entry.value.imagePath, fit: BoxFit.fitHeight,),
            ),
          )).toList(),
        ),
      );
    } else {
      return Container(
        width: width,
        height: (width / maxLen) * 1.53,
        child: Center(
          child: Text(
            'Empty Hand',
            style: AppTheme.headline,
          ),
        ),
      );
    }
  }
}