import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:omi_game/models/player.dart';
import 'package:omi_game/models/tableCard.dart';
import '../models/card.dart';
import 'dart:math';

class CardGame extends ChangeNotifier {
  List<CardSuit> suitList = [CardSuit.Clubs, CardSuit.Diamonds, CardSuit.Hearts, CardSuit.Spades];
  List<CardRank> rankList = [CardRank.Seven, CardRank.Eight, CardRank.Nine, CardRank.Ten, CardRank.Jack, CardRank.Queen, CardRank.King, CardRank.Ace];
  List<PlayingCard> deck;
  List<Player> players;
  List<TableCard> table;
  int gameStater;
  List<int> handResultOne;
  List<int> handResultTwo;
  int ketaOne;
  int ketaTwo;
  bool waitForThurumpu = false;
  CardSuit thurumpu;
  bool waitForSelection = false;
  bool showHandFineshMsg = false;
  String handWinnerMsg = '';
  PlayingCard selectedCard;
  bool lastGameSeporu = false;

  void initGame() {
    deckPopulate();
    
    ketaOne = 10;
    ketaTwo = 10;
  }

  void deckPopulate() {
    deck = [];
    players = [];
    table = [];
    for (CardSuit suit in suitList) {
      for (CardRank rank in rankList) {
        PlayingCard card = PlayingCard(
          suit: suit,
          rank: rank,
          value: rankList.indexOf(rank) + 7,
          imagePath: getImagePath(suit, rank),
          enable: false,
        );
        deck.add(card);
      }
    }
    deck.shuffle();
    for (int i = 0; i < 4; i++) {
      Player player = Player('player_$i');
      player.setPlayerMod(PlayerMod.Slave);
      players.add(player);
    }
    players[0].playerMod = PlayerMod.Master;
  }

  void gameUpdate() {
    notifyListeners();
  }

  String getImagePath(CardSuit suit, CardRank rank) {
    String suitLetter = EnumToString.parse(suit).substring(0, 1);
    String rankLetter = rankList.indexOf(rank) <= 3 ? (rankList.indexOf(rank) + 7).toString() : EnumToString.parse(rank).substring(0, 1);
    return 'images/cards/$rankLetter$suitLetter.png';
  }

  Player getCurrentHandWinner() {
    List<int> valueList = [];
    table.forEach((element) {
      if (element.card.suit == thurumpu) {
        valueList.add(element.card.value + 10); 
      } else if (element.card.suit == table[0].card.suit) {
        valueList.add(element.card.value);
      } else {
        valueList.add(0);
      }
    });
    Player winner = table[valueList.indexOf(valueList.reduce(max))].owner;
    if (winner.name == 'player_0' || winner.name == 'player_2') {
      handResultOne.add(1);
      handResultTwo.add(0);
    } else {
      handResultOne.add(0);
      handResultTwo.add(1);
    }
    return winner;
  }

  void currentGameWinner(int handStarter) {
    int teamOneResult = 0;
    int teamTwoResult = 0;
    handResultOne.forEach((element) {
      teamOneResult += element;
    });
    handResultTwo.forEach((element) {
      teamTwoResult += element;
    });
    if (teamOneResult > teamTwoResult) {
      if (handStarter == 0 || handStarter == 2) {
        if (lastGameSeporu) {
          ketaTwo = ketaTwo - 2;
          handWinnerMsg = 'Your Team Wins!\nGot Two Keta (Last Hand Seporu)';
        } else {
          ketaTwo = ketaTwo - 1;
          handWinnerMsg = 'Your Team Wins!\nGot One Keta';
        }
      } else {
        ketaTwo = ketaTwo - 2;
        handWinnerMsg = 'Your Team Wins!\nGot Two Keta (Other Team\'s Thurumpu)';
      }
      lastGameSeporu = false;
    } else if (teamOneResult < teamTwoResult) {
      if (handStarter == 1 || handStarter == 3) {
        if (lastGameSeporu) {
          ketaOne = ketaOne - 2;
          handWinnerMsg = 'Your Team Lost!\nLoose Two Keta (Last Hand Seporu)';
        } else {
          ketaOne = ketaOne - 1;
          handWinnerMsg = 'Your Team Lost!\nLoose One Keta';
        }
      } else {
        ketaOne = ketaOne - 2;
        handWinnerMsg = 'Your Team Lost!\nLoose Two Keta (Your Team\'s THurumpu)';
      }
      lastGameSeporu = false;
    } else {
      lastGameSeporu = true;
      handWinnerMsg = 'No One Wins!\nHand Seporu';
    }
  }

  Future<CardSuit> getThurumpuFromPlayer() async {
    await Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 200));
      return (thurumpu == null);
    });
    return thurumpu;
  }

  Future<PlayingCard> getSelectedCardFromPlayer() async {
    await Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 200));
      return (selectedCard == null);
    });
    return selectedCard;
  }

  Future<bool> getHandFineshResponse() async {
    await Future.delayed(Duration(seconds: 3));
    handWinnerMsg = '';
    return true;
  }

  void run() async {
    thurumpu = null;
    waitForThurumpu = false;
    lastGameSeporu = false;
    gameStater = 3;
    while (ketaOne >= 1 || ketaTwo >= 1) {
      deckPopulate();
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          players[j].addCard(deck[0]);
          deck.removeAt(0);
        }
      }
      if (players[gameStater == 3 ? 0 : gameStater + 1].playerMod == PlayerMod.Master) {
        waitForThurumpu = true;
        thurumpu = null;
        print('Waiting For Thurumpu');
        await getThurumpuFromPlayer();
        waitForThurumpu = false;
      } else {
        // get thurumpu
        thurumpu = players[gameStater == 3 ? 0 : gameStater + 1].getThurumpu();
      }
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          players[j].addCard(deck[0]);
          deck.removeAt(0);
        }
      }
      int handStater = gameStater == 3 ? 0 : gameStater + 1;
      int currentPlayer = handStater;
      handResultOne = [];
      handResultTwo = [];
      for (int i = 0; i < 8; i++) {
        table = [];
        for (int j = 0; j < 4; j++) {
          if (players[currentPlayer].playerMod != PlayerMod.Master) {
            TableCard tableCard = TableCard(
              owner: players[currentPlayer],
              card: await players[currentPlayer].play(table, thurumpu)
            );
            table.add(tableCard);
          } else {
            selectedCard = null;
            waitForSelection = true;
            players[currentPlayer].setCardEnable(table);
            print('Waiting For Caed Selection');
            await getSelectedCardFromPlayer();
            players[currentPlayer].setCardDiseble();
            waitForSelection = false;
            TableCard tableCard = TableCard(
              owner: players[currentPlayer],
              card: selectedCard
            );
            table.add(tableCard);
            selectedCard = null;
          }
          currentPlayer = currentPlayer == 3 ? 0 : currentPlayer + 1;
        }
        // dinuma thorala current player karanna
        Player lastWinner = getCurrentHandWinner();
        if (lastWinner.name == 'player_0') {
          currentPlayer = 0;
        } else if (lastWinner.name == 'player_1') {
          currentPlayer = 1;
        } else if (lastWinner.name == 'player_2') {
          currentPlayer = 2;
        } else {
          currentPlayer = 3;
        }
        await Future.delayed(Duration(seconds: 3));
        print(handResultOne);
        print(handResultTwo);
      }
      // current game winner
      currentGameWinner(handStater);
      gameStater = handStater;
      showHandFineshMsg = true;
      print('Showing Hand Finesh Msg');
      await getHandFineshResponse();
      showHandFineshMsg = false;
    }
  }
}

