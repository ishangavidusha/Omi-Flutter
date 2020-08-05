
import 'package:enum_to_string/enum_to_string.dart';

class Card {
  CardSuit suit;
  CardRank rank;
  int value;
  String imagePath;

  Card({
    this.suit,
    this.rank,
    this.value,
    this.imagePath
  });

  set setValue(int value) {
    this.value = value;
  }

  int get getValue => this.value != null ? this.value : 0;

  @override
  String toString() {
    if (this.rank != null && this.suit != null) {
      String stringRank = EnumToString.parse(this.rank);
      String stringSuit = EnumToString.parse(this.suit);
      return '$stringRank of $stringSuit';
    } else {
      return 'Card not initialized';
    }
  } 

}

enum CardSuit{Clubs, Hearts, Diamonds, Spades}
enum CardRank{Seven, Eight, Nine, Ten, Jack, Queen, King, Ace}