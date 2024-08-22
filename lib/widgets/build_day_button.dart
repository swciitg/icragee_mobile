import 'package:flutter/material.dart';

import '../shared/colors.dart';

class DayButton extends StatelessWidget {
  final int dayNumber;
  final int selectedDay;
  final Function(int) onPressed;

  const DayButton({
    Key? key,
    required this.dayNumber,
    required this.selectedDay,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedDay == dayNumber;
    return OutlinedButton(
      onPressed: () => onPressed(dayNumber),
      child: Text('Day ${dayNumber}'),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? MyColors.backgroundColor : Colors.white,
        foregroundColor: isSelected ? MyColors.primaryColor : Colors.black,
        side: BorderSide(color: Colors.teal),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(100, 45), // Width: 100, Height: 40
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      ),
    );
  }
}
