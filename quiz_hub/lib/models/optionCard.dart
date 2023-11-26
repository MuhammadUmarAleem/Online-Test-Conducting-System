import 'package:flutter/material.dart';
import 'package:quiz_hub/models/constants.dart';

class OptionCard extends StatelessWidget {
  OptionCard({
    super.key,
    required this.option,
    required this.onTap,
    required this.isSelected,
    required this.isCorrect,
  });

  final String option;
  final VoidCallback onTap;
  bool isSelected;
  bool isCorrect;
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    IconData? iconData;
    Color iconColor;
    Color tileColor;
    Color textColor;

    if (isSelected) {
      if (isCorrect) {
        iconData = Icons.check;
        iconColor = Colors.green;
        tileColor = Colors.white;
        textColor = Colors.green;
      } else {
        iconData = Icons.close;
        iconColor = Colors.red;
        tileColor = Colors.white;
        textColor = Colors.red;
      }
    } else {
      iconData = null;
      iconColor = Colors.transparent;
      tileColor = constants.darkPurple;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: tileColor,
        child: ListTile(
          title: Row(
            children: [
              if (iconData != null) Icon(iconData, color: iconColor),
              SizedBox(width: iconData != null ? 8 : 0),
              Text(option, style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
