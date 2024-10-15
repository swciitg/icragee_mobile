import 'package:flutter/material.dart';

import '../shared/colors.dart';

class TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const TabButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? MyColors.primaryColor : MyColors.backgroundColor,
          boxShadow: [
            if (isSelected)
              const BoxShadow(
                color: Color.fromRGBO(28, 28, 28, 0.3),
                blurRadius: 24,
                spreadRadius: 0,
              ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : MyColors.primaryTextColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
