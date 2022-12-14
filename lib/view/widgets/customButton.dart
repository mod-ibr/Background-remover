import 'package:background_remover/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Icon icon;
  String text;
  Function onpressed;
  CustomButton(
      {super.key,
      required this.icon,
      required this.onpressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(
        text,
        textAlign: TextAlign.center,
      ),
      onPressed: () => onpressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(PRIMARY_COLOR),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
