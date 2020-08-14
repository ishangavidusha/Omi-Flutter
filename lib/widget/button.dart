import 'package:flutter/material.dart';
import 'package:omi_game/theme/appTheme.dart';

class KButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const KButton(
      {Key key,
      this.text,
      this.onPressed,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: devWidth * 0.5,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(colors: [AppTheme.darkGreen, AppTheme.lightGreen]),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0.0, 10),
            blurRadius: 10,
          ),
        ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppTheme.headline
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}