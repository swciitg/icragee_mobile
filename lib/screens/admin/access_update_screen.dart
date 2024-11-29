import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/profile_screen/profile_details_card.dart';

class AccessUpdateScreen extends StatefulWidget {
  final UserDetails user;
  const AccessUpdateScreen({super.key, required this.user});

  @override
  State<AccessUpdateScreen> createState() => _AccessUpdateScreenState();
}

class _AccessUpdateScreenState extends State<AccessUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _appBar(context),
      body: Column(
        children: [
          const SizedBox(height: 16),
          ProfileDetailsCard(user: widget.user, includeName: true),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Update Access",
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
    );
  }
}
