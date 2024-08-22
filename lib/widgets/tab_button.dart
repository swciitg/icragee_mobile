import 'package:flutter/material.dart';

import '../shared/colors.dart';

class TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const TabButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? MyColors.primaryColor : MyColors.backgroundColor,
        foregroundColor: isSelected ? Colors.white : MyColors.primaryColor,
        side: BorderSide(color: Colors.teal),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
