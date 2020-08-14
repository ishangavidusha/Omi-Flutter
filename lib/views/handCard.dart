import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omi_game/engin/game.dart';
import 'package:omi_game/models/card.dart';
import 'package:provider/provider.dart';

class HandCard extends StatefulWidget {
  final PlayingCard card;
  final int index;
  final Function onExit;

  const HandCard({Key key, this.card, this.index, this.onExit}) : super(key: key);
  @override
  _HandCardState createState() => _HandCardState();
}

class _HandCardState extends State<HandCard> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );
    Timer(Duration(milliseconds: widget.index * 100), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    CardGame cardGame = Provider.of<CardGame>(context);
    return Transform.translate(
      offset: Offset(20 - (_animation.value * 20), 0),
      child: FadeTransition(
        opacity: _animation,
        child: Image.asset(
          widget.card.imagePath, fit: BoxFit.fitHeight,
          colorBlendMode: BlendMode.darken,
          color: cardGame.waitForSelection && !widget.card.enable ? Colors.black.withOpacity(0.4) : null,
        ),
      ),
    );
  }
}