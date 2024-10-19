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
    super.key,
    required this.title,
    required this.location,
    required this.time,
    required this.imageFile,
    required this.isLost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Text section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevents overflow
                  ),
                  Text(
                    '${isLost ? "Lost at" : "Found at"}: $location',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevents overflow
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: MyColors.primaryColorTint,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      time,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 130, maxWidth: 155),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.file(
                File(imageFile), // Display the image from XFile
                width: 150,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
