import 'package:flutter/material.dart';

class TableCardView extends StatefulWidget {
  final String imagePath;
  final AnimationDirection direction;

  const TableCardView({Key key, this.imagePath, this.direction}) : super(key: key);
  @override
  _TableCardViewState createState() => _TableCardViewState();
}

class _TableCardViewState extends State<TableCardView> with TickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset getOffset(AnimationDirection animationDirection) {
    switch (animationDirection) {
      case AnimationDirection.Up:
        return Offset(0, 20 - (_animation.value * 20));
        break;
      case AnimationDirection.Down:
        return Offset(0, -20 + (_animation.value * 20));
        break;
      case AnimationDirection.Left:
        return Offset(-20 + (_animation.value * 20), 0);
        break;
      case AnimationDirection.Right:
        return Offset(20 - (_animation.value * 20), 0);
        break;
      default:
        return Offset(0, 0);
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Transform.translate(
      offset: getOffset(widget.direction),
      child: Opacity(
        opacity: _animation.value,
        child: Image.asset(widget.imagePath),
      ),
    );
  }
}

enum AnimationDirection{Left, Right, Up, Down}