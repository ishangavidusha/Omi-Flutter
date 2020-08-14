import 'package:omi_game/models/tableCard.dart';
import 'card.dart';
import 'dart:math';
enum PlayerMod{Master, Slave}

class Player {
  String name;
  PlayerMod playerMod;
  List<PlayingCard> hand = [];

  Player(this.name);

  PlayingCard getCard(PlayingCard card) {
    this.hand.removeWhere((element) => element.rank == card.rank && element.suit == card.suit && element.value == card.value);
    return card;
  }

  void addCard(PlayingCard card) {
    hand.add(card);
  }

  void setPlayerMod(PlayerMod mod) {
    this.playerMod = mod;
  }

  CardSuit getThurumpu() {
    List<CardSuit> suitList = [CardSuit.Clubs, CardSuit.Diamonds, CardSuit.Hearts, CardSuit.Spades];
    List<int> suitGroup = [0, 0, 0, 0];
    for (PlayingCard card in this.hand) {
      if (card.suit == suitList[0]) {
        suitGroup[0] += 1;
      } else if (card.suit == suitList[1]) {
        suitGroup[1] += 1;
      } else if (card.suit == suitList[2]) {
        suitGroup[2] += 1;
      } else {
        suitGroup[3] += 1;
      }
    }
    if (suitGroup.reduce(max) == 1) {
      return this.hand[getMax(this.hand)].suit;
    } else if (suitGroup.reduce(max) == 2) {
      return this.hand[getMax(this.hand)].suit;
    }
    return suitList[suitGroup.indexOf(suitGroup.reduce(max))];
  }

  void setCardEnable(List<TableCard> tableCard) {
    List<PlayingCard> playable = [];
    if (tableCard.isEmpty) {
      for (int i = 0; i < hand.length; i++) {
        hand[i].enable = true;
      }
    } else {
      hand.forEach((element) {
        if (tableCard[0].card.suit == element.suit) {
          playable.add(element);
        }
      });
      if (playable.length > 0) {
        for (int i = 0; i < hand.length; i++) {
          if (tableCard[0].card.suit == hand[i].suit) {
            hand[i].enable = true;
          } else {
            hand[i].enable = false;
          }
        }
      } else {
        for (int i = 0; i < hand.length; i++) {
          hand[i].enable = true;
        }
      }
    }
  }

  void setCardDiseble() {
    for (int i = 0; i < hand.length; i++) {
      hand[i].enable = false;
    }
  }

  int getMin(List<PlayingCard> list) {
    PlayingCard min = list[0];
    list.forEach((element) {
      min = min.value.compareTo(element.value) >= 0 ? element : min;
    });
    return list.indexOf(min);
  }

  int getMax(List<PlayingCard> list) {
    PlayingCard max = list[0];
    list.forEach((element) {
      max = max.value.compareTo(element.value) >= 0 ? max : element;
    });
    return list.indexOf(max);
  }

  int nonThurumpuMin(CardSuit thurumpu) {
    // thurmpu nowan aduma kole
    List<PlayingCard> nonThurumpu = [];
    List<PlayingCard> myThurumpu = [];
    this.hand.forEach((element) {
      if (element.suit == thurumpu) {
        myThurumpu.add(element);
      } else {
        nonThurumpu.add(element);
      }
    });
    if (nonThurumpu.isEmpty) {
      return this.hand.indexOf(myThurumpu[getMin(myThurumpu)]);
    } else {
      return this.hand.indexOf(nonThurumpu[getMin(nonThurumpu)]);
    }
  }


  Future<PlayingCard> play(List<TableCard> tableCard, CardSuit thurumpu) async {
    await Future.delayed(Duration(seconds: 1));
    List<PlayingCard> table = [];
    tableCard.forEach((element) {
      table.add(element.card);
    });
    PlayingCard cardToPlay;
    if (this.hand.length > 1) {
      if (table.isNotEmpty) {
        CardSuit currentSuit = table[0].suit;
        List<PlayingCard> playableCard= [];
        hand.forEach((element) {
          if (element.suit == currentSuit) {
            playableCard.add(element);
          }
        });
        List<PlayingCard> myThurumpu = [];
        hand.forEach((element) {
          if (element.suit == thurumpu) {
            myThurumpu.add(element);
          }
        });
        PlayingCard tableMax = table[getMax(table)];
        if (playableCard.isNotEmpty && playableCard.length > 1) {
          //When I have table suit
          switch (table.length) {
            case 1:
              if (tableMax.value > playableCard[getMax(playableCard)].value) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else {
                cardToPlay = getCard(playableCard[getMax(playableCard)]);
              }
              break;
            case 2:
              if (table[0].value > playableCard[getMax(playableCard)].value) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else if (table[0].value == 13 && playableCard[getMax(playableCard)].value == 14) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else if (table[0].suit != thurumpu && table[1].suit == thurumpu) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else {
                cardToPlay = getCard(playableCard[getMax(playableCard)]);
              }
              break;
            case 3:
              if (table[0].suit != thurumpu && table[1].suit == thurumpu) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else if (table[0].suit != thurumpu && table[2].suit == thurumpu) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else if (table[0].suit == table[1].suit && table.indexOf(tableMax) == 1) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else if (table[1].value == 13 && playableCard[getMax(playableCard)].value == 14 && table[1].suit == cardToPlay.suit) {
                cardToPlay = getCard(playableCard[getMin(playableCard)]);
              } else {
                cardToPlay = getCard(playableCard[getMax(playableCard)]);
              }
              break;
            default:
          }
        } else if (playableCard.length == 1) {
          cardToPlay = getCard(playableCard[0]);
        } else {
          switch (table.length) {
            case 1:
              if (table[0].suit == thurumpu) {
                cardToPlay = getCard(this.hand[getMin(this.hand)]);
              } else if (myThurumpu.length > 0) {
                cardToPlay = getCard(this.hand[getMax(myThurumpu)]);
              } else {
                cardToPlay = getCard(this.hand[getMin(this.hand)]);
              }
              break;
            case 2:
              if (table[0].suit == thurumpu) {
                cardToPlay = getCard(this.hand[getMin(this.hand)]);
              } else if (table[1].suit == thurumpu) {
                if (myThurumpu.length > 0 && this.hand[getMax(myThurumpu)].value > table[1].value) {
                  cardToPlay = getCard(this.hand[getMax(myThurumpu)]);
                } else if (myThurumpu.length > 0) {
                  // thurumpu nowana min
                  cardToPlay = getCard(this.hand[nonThurumpuMin(thurumpu)]);
                } else {
                  cardToPlay = getCard(this.hand[getMin(this.hand)]);
                }
              } else if (table.indexOf(tableMax) == 1 && myThurumpu.length > 0) {
                cardToPlay = getCard(this.hand[getMin(myThurumpu)]);
              } else if (myThurumpu.length > 0) {
                // thurumpu gahanawada nedda
                if (table[0].value > 10) {
                  cardToPlay = getCard(this.hand[nonThurumpuMin(thurumpu)]);
                } else {
                  cardToPlay = getCard(this.hand[getMax(myThurumpu)]);
                }
              } else {
                cardToPlay = getCard(this.hand[getMin(this.hand)]);
              }
              break;
            case 3:
              if (table[0].suit == thurumpu) {
                cardToPlay = getCard(this.hand[getMin(this.hand)]);
              } else if (myThurumpu.length > 0) {
                if (table[1].suit == thurumpu && table[2].suit == thurumpu) {
                  if (table[1].value > table[2].value) {
                    // thurumpu nowana aduma kole
                    cardToPlay = getCard(this.hand[nonThurumpuMin(thurumpu)]);
                  } else if (table[2].value > this.hand[getMax(myThurumpu)].value) {
                    cardToPlay = getCard(this.hand[getMax(myThurumpu)]);
                  } else {
                    // thurumpu nowana aduma kole
                    cardToPlay = getCard(this.hand[nonThurumpuMin(thurumpu)]);
                  }
                } else if (table[2].suit == thurumpu) {
                  if (table[2].value > this.hand[getMax(myThurumpu)].value) {
                    cardToPlay = getCard(this.hand[getMax(myThurumpu)]);
                  } else {
                    // thurumpu nowana aduma kole
                    cardToPlay = getCard(this.hand[nonThurumpuMin(thurumpu)]);
                  }
                } else {
                  // thurumpu nowana aduma kole
                  cardToPlay = getCard(this.hand[getMin(myThurumpu)]);
                }
              } else {
                cardToPlay = getCard(this.hand[getMin(this.hand)]);
              }
              break;
            default:
          }
        }
      } else {
        cardToPlay = getCard(this.hand[getMax(this.hand)]);
      }
    } else {
      cardToPlay = getCard(this.hand[0]);
    }
    return cardToPlay;
  }
}