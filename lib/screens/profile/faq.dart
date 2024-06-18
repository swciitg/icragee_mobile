import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/tiles.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: Text("FAQs"),
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Container(
        //color: MyColors.backgroundColor,
        padding: EdgeInsets.all(9),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(7, (index) => const Faqtiles()),
          ),
        ),
      ),
    );
  }
}
