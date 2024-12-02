import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/lost_found_model.dart';
import 'package:icragee_mobile/services/data_service.dart';

import '../../shared/colors.dart';

class ItemCard extends StatelessWidget {
  final LostFoundModel item;
  final bool deleteOption;

  const ItemCard({
    super.key,
    required this.item,
    this.deleteOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                        item.title,
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                      Text(
                        '${item.category == 'lost' ? "Lost at " : "Found at "}: ${item.location}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: MyColors.primaryColorTint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _formatTimestamp(item.submittedAt),
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
                constraints:
                    const BoxConstraints(maxHeight: 130, maxWidth: 155),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    item.imageUrl,
                    width: 150,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (deleteOption)
          Positioned(
            top: 16,
            right: 32,
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: const Text("Delete Item?"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              DataService.deleteLostFoundItem(item.id);
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.delete_rounded, color: Colors.white),
              ),
            ),
          )
      ],
    );
  }

  String _formatTimestamp(String timestamp) {
    final DateTime date = DateTime.parse(timestamp);
    final Duration difference = DateTime.now().difference(date);
    if (difference.inDays > 1) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 1) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 1) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
