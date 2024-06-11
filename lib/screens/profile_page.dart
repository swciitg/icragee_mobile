import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/home_screen.dart';
import 'package:icragee_mobile/shared/colors.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  int selectedIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: Text('My profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    //backgroundImage: AssetImage('assets/profile_picture.jpg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abhishek Sinha',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('ID 2209753728'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.contacts),
                title: Text('Important contacts'),
                trailing: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Feedback'),
                trailing: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('FAQs'),
                trailing: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.pink.shade50,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 60,
          elevation: 4,
          shadowColor: Colors.black,
          surfaceTintColor: MyColors.navBarBackgroundColor,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: MyColors.secondaryColor);
            } else {
              return const IconThemeData(color: Colors.grey);
            }
          }),
        ),
        child: NavigationBar(
            backgroundColor: MyColors.navBarBackgroundColor,
            selectedIndex: selectedIndex,
            onDestinationSelected: (i) => setState(() {
                  if ((i - selectedIndex).abs() != 1) {
                    pageController.jumpToPage(i);
                  } else {
                    pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeIn);
                  }
                  selectedIndex = i;
                }),
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  FluentIcons.home_48_filled,
                  size: 28,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.calendar_48_filled,
                  size: 28,
                ),
                label: 'Schedule',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.location_48_filled,
                  size: 28,
                ),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.food_48_filled,
                  size: 28,
                ),
                label: 'Food',
              ),
            ]),
      ),
    );
  }
}
