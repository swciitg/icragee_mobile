import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/home_screen.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/screens/feedback/feedback_page.dart';
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
                padding: const EdgeInsets.all(16),
                child:const Row(
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
             const  SizedBox(height: 26),
              ListTile(
                tileColor: MyColors.navBarBackgroundColor,
                leading:const Icon(Icons.contacts),
                title: const Text('Important contacts'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImportantContacts()));
                  },
                  child: Container(
                    decoration:const BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child:const Padding(
                      padding: EdgeInsets.all(6.0),
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
                leading:const Icon(Icons.feedback),
                title:const Text('Feedback'),
                trailing: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> const FeedbackPage()));
                  },
                  child: Container(
                    decoration:const BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child:const Padding(
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
                leading:const Icon(Icons.help),
                title:const Text('FAQs'),
                trailing: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration:const BoxDecoration(
                      color: MyColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.all(6.0),
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
