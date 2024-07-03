import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/tiles.dart';

class FaqScreen extends StatefulWidget {
  FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text("FAQs"),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(9),
        child: FutureBuilder<List<Faqs>>(
          future: DataService.fetchFaqs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No FAQs available.'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children:
                      snapshot.data!.map((faq) => Faqtiles(faq: faq)).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
