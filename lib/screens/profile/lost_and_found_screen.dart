import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/widgets/lost_found/add_item_button.dart';
import 'package:icragee_mobile/widgets/lost_found/found_items_list.dart';
import 'package:icragee_mobile/widgets/lost_found/lost_items_list.dart';
import 'package:icragee_mobile/widgets/lost_found/myads_list.dart';
import '../../shared/colors.dart';

class LostAndFoundScreen extends ConsumerStatefulWidget {
  const LostAndFoundScreen({super.key});

  @override
  ConsumerState<LostAndFoundScreen> createState() => _LostAndFoundScreenState();
}

class _LostAndFoundScreenState extends ConsumerState<LostAndFoundScreen> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildTabs(),
          _buildItemsList(),
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return selected == 1
        ? LostItemsList()
        : selected == 2
            ? FoundItemsList()
            : MyAdsList();
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
}
