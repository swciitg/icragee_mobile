import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/widgets/lost_found/add_item_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/colors.dart';
import '../../widgets/lost_found/item_card.dart';

class LostAndFoundScreen extends StatefulWidget {
  const LostAndFoundScreen({super.key});

  @override
  State<LostAndFoundScreen> createState() => _LostAndFoundScreenState();
}

class _LostAndFoundScreenState extends State<LostAndFoundScreen> {
  int selected = 1; // By default, the first tab (Lost Items) is selected
  late Stream<QuerySnapshot> itemStream;

  @override
  void initState() {
    super.initState();
    _getItems(); // Initialize the stream for lost items by default
  }

  void _getItems() {
    setState(() {
      if (selected == 1) {
        // Fetch lost items from "lost_items" collection
        itemStream = FirebaseFirestore.instance
            .collection('lost_items')
            .orderBy('submittedAt', descending: true)
            .snapshots();
      } else if (selected == 2) {
        // Fetch found items from "found_items" collection
        itemStream = FirebaseFirestore.instance
            .collection('found_items')
            .orderBy('submittedAt', descending: true)
            .snapshots();
      } else {
        // My Ads logic, modify as needed
        itemStream = FirebaseFirestore.instance
            .collection('lost_items') // Example for showing "My Ads"
            .snapshots();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Lost and Found',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildTabs(),
          Expanded(
            child: StreamBuilder(
              stream: itemStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No items found"));
                }
                final items = snapshot.data!.docs;
                return ListView(
                  children: items.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return ItemCard(
                      title: data['title'] ?? 'No Title',
                      location: data['location'] ?? 'Unknown location',
                      time: _formatTimestamp(data['submittedAt']),
                      imageFile: data['image'] ?? 'assets/images/logo.png',
                      isLost: selected == 1,
                      deleteOption: selected == 3,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AddItemButton(
        type: selected == 1
            ? 'Lost'
            : selected == 2
                ? 'Found'
                : 'MyAds',
      ),
    );
  }

  Widget _buildTabs() {
    final titles = ['Lost Items', 'Found Items', 'My Ads'];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8,
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.start,
        children: List.generate(titles.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = index + 1;
              });
              _getItems();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: ShapeDecoration(
                color: selected == index + 1 ? MyColors.whiteColor : MyColors.primaryColorTint,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                titles[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: MyColors.primaryColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Unknown time";
    final DateTime date = timestamp.toDate();
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
