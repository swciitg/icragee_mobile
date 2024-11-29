import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/profile_screen/profile_details_card.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';

class AccessUpdateScreen extends StatefulWidget {
  final UserDetails user;
  const AccessUpdateScreen({super.key, required this.user});

  @override
  State<AccessUpdateScreen> createState() => _AccessUpdateScreenState();
}

class _AccessUpdateScreenState extends State<AccessUpdateScreen> {
  var inCampus = false;
  var loading = false;

  @override
  void initState() {
    inCampus = widget.user.inCampus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _appBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Stack(
                children: [
                  ProfileDetailsCard(user: widget.user, includeName: true),
                  if (inCampus)
                    Positioned(
                      right: 24,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Present",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (loading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: _markPresentButton(),
    );
  }

  Widget _markPresentButton() {
    if (inCampus) return const SizedBox();
    return GestureDetector(
      onTap: () async {
        if (loading) return;
        setState(() {
          loading = true;
        });
        try {
          await DataService.markPresentInCampus(widget.user.id);
          setState(() {
            inCampus = true;
          });
        } catch (e) {
          showSnackBar("Something went wrong");
        }
        setState(() {
          loading = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Mark present in-person",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8),
            Icon(Icons.hail_rounded, color: Colors.white)
          ],
        ),
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
