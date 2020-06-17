import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.buttonColor, this.buttonText, this.onButtonTap});

  final String buttonText;
  final Color buttonColor;
  final Function onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: buttonColor,
        child: MaterialButton(
          onPressed: () {
            onButtonTap();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
