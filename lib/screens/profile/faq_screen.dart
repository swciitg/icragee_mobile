import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/faq_tile.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: Container(
        padding: const EdgeInsets.all(9),
        child: FutureBuilder<List<FaqContent>>(
          future: DataService.fetchFaqs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No FAQs available.'));
            } else {
              final faqs = snapshot.data!;
              return ListView.builder(
                itemCount: faqs.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => FaqTile(faq: faqs[index]),
              );
            }
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: MyColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: MyColors.whiteColor,
        ),
      ),
      title: Text(
        "FAQs",
        style: GoogleFonts.poppins(
          fontSize: 22,
          color: MyColors.whiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
