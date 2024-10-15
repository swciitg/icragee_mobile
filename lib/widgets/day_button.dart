import 'package:flutter/material.dart';

import '../shared/colors.dart';

class DayButton extends StatelessWidget {
  final int dayNumber;
  final int selectedDay;
  final Function(int) onPressed;

  const DayButton({
    super.key,
    required this.dayNumber,
    required this.selectedDay,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedDay == dayNumber;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? MyColors.backgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => onPressed(dayNumber),
          child: Center(
            child: Text(
              'Day $dayNumber',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? MyColors.primaryColor : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
