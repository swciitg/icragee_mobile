import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/colors.dart';
import '../../widgets/lost_found/item_card.dart';

class LostAndFoundScreen extends StatefulWidget {
  @override
  _LostAndFoundScreenState createState() => _LostAndFoundScreenState();
}

class _LostAndFoundScreenState extends State<LostAndFoundScreen> {
  int selected = 1; // By default, the first tab (Lost Items) is selected

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
            child: ListView(
              children: getFilteredItems().map((item) {
                return ItemCard(
                  title: item['title'],
                  location: item['location'],
                  time: item['time'],
                  imagePath: item['imagePath'],
                  isLost: item['isLost'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
