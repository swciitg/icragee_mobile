import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/widgets/lost_found/add_item_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/colors.dart';
import '../../widgets/lost_found/item_card.dart';

class LostAndFoundScreen extends StatefulWidget {
  @override
  _LostAndFoundScreenState createState() => _LostAndFoundScreenState();
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

  // Dummy data for items
  final List<Map<String, dynamic>> items = [
    {
      'title': 'cello Swift 1 litre',
      'location': 'Room 1204',
      'time': '3 hours ago',
      'imagePath': 'assets/images/logo.png',
      'isLost': true
    },
    {
      'title': 'ID card',
      'location': 'near central...',
      'time': 'a day ago',
      'imagePath': 'assets/images/logo.png',
      'isLost': true
    },
    {
      'title': 'earphone',
      'location': 'Lecture Hall...',
      'time': 'a day ago',
      'imagePath': 'assets/images/logo.png',
      'isLost': true
    },
    {
      'title': 'earphone',
      'location': 'Lecture Hall...',
      'time': 'a day ago',
      'imagePath': 'assets/images/logo.png',
      'isLost': false
    },
    {
      'title': 'earphone',
      'location': 'Lecture Hall...',
      'time': 'a day ago',
      'imagePath': 'assets/images/logo.png',
      'isLost': true
    },
  ];

  // Function to filter items based on the selected tab
  List<Map<String, dynamic>> getFilteredItems() {
    if (selected == 1) {
      return items
          .where((item) => item['isLost'] == true)
          .toList(); // Lost Items
    } else if (selected == 2) {
      return items
          .where((item) => item['isLost'] == false)
          .toList(); // Found Items
    } else {
      // For "My Ads", you can add your own logic to filter based on user ads
      return items; // For now, return all items as a placeholder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: Text('Lost and Found'),
        backgroundColor: MyColors.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 1;
                    });
                    _getItems(); // Update items when tab is switched
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: ShapeDecoration(
                      color: selected == 1
                          ? MyColors.whiteColor
                          : MyColors.primaryColorTint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x331C1C1C),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Text(
                      'Lost Items',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 2;
                    });
                    _getItems(); // Update items when tab is switched
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: ShapeDecoration(
                      color: selected == 2
                          ? MyColors.whiteColor
                          : MyColors.primaryColorTint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x331C1C1C),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Text(
                      'Found Items',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 3;
                    });
                    _getItems(); // Update items when tab is switched
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: ShapeDecoration(
                      color: selected == 3
                          ? MyColors.whiteColor
                          : MyColors.primaryColorTint,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x331C1C1C),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Text(
                      'My Ads',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: itemStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No items found"));
                }
                final items = snapshot.data!.docs;
                return ListView(
                  children: items.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    // Check if the 'image' is an XFile and convert it
                    String imagePath = data['image'] is XFile
                        ? (data['image'] as XFile).path
                        : data['image'] ?? 'assets/images/logo.png';

                    return ItemCard(
                      title: data['title'] ?? 'No Title',
                      location: data['location'] ?? 'Unknown location',
                      time: _formatTimestamp(data['submittedAt']),
                      imageFile: data['image'] ?? 'assets/images/logo.png',
                      isLost: selected == 1,
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
                : 'MyAds', // Pass the correct type
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
    } else {
      return "Just now";
    }
  }
}
