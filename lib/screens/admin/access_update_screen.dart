import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/admin/food_coupon_update.dart';
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
    inCampus = widget.user.inCampus ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _appBar(context),
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      ProfileDetailsCard(user: widget.user, admin: false),
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
                  const SizedBox(height: 16),
                  if (inCampus)
                    StreamBuilder(
                      stream: DataService.getUserMealAccessSteam(widget.user.id),
                      builder: (context, snapshot) {
                        List<MealAccess> meals = [];
                        if (!snapshot.hasData) {
                          meals = widget.user.mealAccess!;
                        } else {
                          meals = snapshot.data!;
                        }
                        return FoodCouponUpdate(
                          meals: meals,
                          onUpdate: (updatedList) async {
                            setState(() {
                              loading = true;
                            });
                            try {
                              final meals = widget.user.mealAccess;
                              meals!.removeWhere((e) => e.day == updatedList.first.day);
                              meals.addAll(updatedList);
                              final user = widget.user.copyWith(
                                mealAccess: meals,
                                inCampus: inCampus,
                              );

                              await DataService.updateUserDetails(
                                user,
                                containsFirestoreData: true,
                              );
                            } catch (e) {
                              showSnackBar("Something went wrong!");
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                        );
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Only super-admins can revert things",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (loading)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.3),
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
    return Consumer(builder: (context, ref, child) {
      final user = ref.read(userProvider)!;
      final hasAccess =
          user.role == AdminRole.superAdmin || user.role == AdminRole.registrationVolunteer;
      final superUser = user.role == AdminRole.superAdmin;
      return GestureDetector(
        onTap: () async {
          if (!hasAccess) {
            showSnackBar("You don't have access to do this");
            return;
          }
          if (!superUser && !inCampus) {
            showSnackBar("Only super-admins can revert things");
            return;
          }
          if (loading) return;
          setState(() {
            loading = true;
          });
          try {
            await DataService.markPresentInCampus(widget.user.id, !inCampus);
            setState(() {
              inCampus = !inCampus;
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
                inCampus ? "Not in-campus" : "Present in-campus",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8),
              Icon(Icons.hail_rounded, color: Colors.white)
            ],
          ),
        ),
      );
    });
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }
}
