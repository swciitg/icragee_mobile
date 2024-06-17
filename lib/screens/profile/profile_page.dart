import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/home_screen.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
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
              Container(
                decoration: BoxDecoration(
                    color: MyColors.navBarBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(16),
                child: Row(
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
              ),
              SizedBox(height: 26),
              ListTile(
                tileColor: MyColors.navBarBackgroundColor,
                leading: Icon(Icons.contacts),
                title: Text('Important contacts'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImportantContacts()));
                  },
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
              // SizedBox(height: 16),
              ListTile(
                tileColor: MyColors.navBarBackgroundColor,
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
              //SizedBox(height: 16),
              ListTile(
                tileColor: MyColors.navBarBackgroundColor,
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
    );
  }
}
