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
  late Future<List<Faqs>> faqListFuture;

  @override
  void initState() {
    super.initState();
    faqListFuture = DataService().fetchFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: Text("FAQs"),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: FutureBuilder<List<Faqs>>(
          future: DataService().fetchFaqs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No FAQs available.'));
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
