import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/colors.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String location;
  final String time;
  final String imageFile;
  final bool isLost;

  const ItemCard({
    Key? key,
    required this.title,
    required this.location,
    required this.time,
    required this.imageFile,
    required this.isLost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
                Text(
                  '${isLost ? "Lost at" : "Found at"}: $location',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
              ],
            ),
          ),

          // Image section
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(imageFile), // Display the image from XFile
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
