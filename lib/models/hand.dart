import 'package:flutter/cupertino.dart';
import 'package:omi_game/models/card.dart';
import 'package:omi_game/theme/appTheme.dart';

class Hand {
  List<PlayingCard> cards;

  Hand({
    this.cards
  });

  addCards(PlayingCard card) {
    this.cards.add(card);
  }

  PlayingCard getCard(PlayingCard card) {
    this.cards.removeWhere((element) => element.rank == card.rank && element.suit == card.suit);
    return card;
  }
}