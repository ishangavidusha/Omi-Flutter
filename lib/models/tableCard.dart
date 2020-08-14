import 'package:omi_game/models/card.dart';
import 'package:omi_game/models/player.dart';

class TableCard {
  Player owner;
  PlayingCard card;
  TableCard({this.owner, this.card});
}