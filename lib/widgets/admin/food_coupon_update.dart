import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';

class FoodCouponUpdate extends StatefulWidget {
  final List<MealAccess> meals;
  final Function(List<MealAccess>) onUpdate;

  const FoodCouponUpdate({
    super.key,
    required this.meals,
    required this.onUpdate,
  });

  @override
  State<FoodCouponUpdate> createState() => _FoodCouponUpdateState();
}

class _FoodCouponUpdateState extends State<FoodCouponUpdate> {
  var selectedDay = 1;
  List<MealAccess> mealAccess = [];

  @override
  void initState() {
    mealAccess = widget.meals.where((e) => e.day == selectedDay).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Food coupon update",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          DropdownButtonFormField<int>(
            padding: EdgeInsets.zero,
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: Colors.black87),
              filled: true,
              fillColor: Colors.transparent,
              border: _buildInputBorder(),
              enabledBorder: _buildInputBorder(),
              focusedBorder: _buildInputBorder(),
              prefixIcon: const Icon(Icons.calendar_today),
            ),
            value: selectedDay,
            hint: const Text('Day'),
            items: List.generate(4, (index) {
              return DropdownMenuItem<int>(
                value: index + 1,
                child: Text('Day ${index + 1}'),
              );
            }),
            onChanged: (newValue) {
              if (newValue == null) return;
              setState(() {
                selectedDay = newValue;
                mealAccess =
                    widget.meals.where((e) => e.day == selectedDay).toList();
              });
            },
          ),
          ...List.generate(
            mealAccess.length,
            (index) {
              final meal = mealAccess[index];
              return _buildMealRow(meal.mealType, meal.taken);
            },
          )
        ],
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }

  Widget _buildMealRow(String title, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff1C1C1C),
          ),
        ),
        Consumer(builder: (context, ref, child) {
          final superUser = ref.read(userProvider)!.role != AdminRole.guest;
          return Switch(
            value: value,
            activeColor: MyColors.primaryColor,
            onChanged: (val) {
              if (!superUser && !val) {
                showSnackBar("Only super-admins can revert things");
                return;
              }
              final index = mealAccess.indexWhere((e) {
                return e.day == selectedDay && e.mealType == title;
              });
              mealAccess.removeAt(index);
              final updatedMeal =
                  MealAccess(day: selectedDay, mealType: title, taken: val);
              if (index == mealAccess.length) {
                mealAccess.add(updatedMeal);
              } else {
                mealAccess.insert(index, updatedMeal);
              }
              widget.onUpdate(mealAccess);
            },
          );
        }),
      ],
    );
  }
}
