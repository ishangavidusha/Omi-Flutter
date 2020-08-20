import 'package:omi_game/models/card.dart';

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