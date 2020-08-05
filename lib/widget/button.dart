import 'package:flutter/material.dart';
import 'package:omi_game/theme/appTheme.dart';

class KButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Icon icon;

  const KButton(
      {Key key,
      this.text,
      this.onPressed,
      this.icon,})
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
        gradient: LinearGradient(colors: [AppTheme.darkGreen, AppTheme.darkGreen]),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightGreen.withOpacity(0.4),
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