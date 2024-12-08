import 'package:flutter/material.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  var selectedDay = 1;
  var breakfastCount = 0;
  var lunchCount = 0;
  var dinnerCount = 0;

  @override
  void initState() {
    selectedDay = (DateTime.now().day - dayOneDate.day).clamp(0, 4);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: 'Select Day',
                labelStyle: const TextStyle(color: Colors.black87),
                filled: true,
                fillColor: Colors.white,
                border: _buildInputBorder(),
                enabledBorder: _buildInputBorder(),
                focusedBorder: _buildInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
              ),
              value: selectedDay,
              hint: const Text('Day'),
              items: List.generate(5, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text("Day $index"),
                );
              }),
              onChanged: (newValue) {
                if (newValue == null) return;
                setState(() {
                  selectedDay = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder(
                future: DataService.getMealAcessofUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data found'));
                  }
                  final allMeals = snapshot.data!;
                  final dayMeals = allMeals.where((e) => e.day == selectedDay).toList();
                  breakfastCount =
                      dayMeals.where((e) => e.mealType == 'Breakfast' && e.taken).length;
                  lunchCount = dayMeals.where((e) => e.mealType == 'Lunch' && e.taken).length;
                  dinnerCount = dayMeals.where((e) => e.mealType == 'Dinner' && e.taken).length;

                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Breakfast",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              breakfastCount.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Lunch",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              lunchCount.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Dinner",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              dinnerCount.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Meal Details',
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

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.black),
    );
  }
}
