import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/shared/colors.dart';

class FaqTile extends StatefulWidget {
  final FaqContent faq;

  const FaqTile({super.key, required this.faq});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.faq.question,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: MyColors.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      isClicked ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isClicked)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.grey), // This is the divider
                Text(
                  widget.faq.answer,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
