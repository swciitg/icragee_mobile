import 'package:flutter/material.dart';
import 'package:icragee_mobile/screens/profile/important_contacts.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/contacts_widget.dart';

class Transport extends StatelessWidget {
  const Transport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Transport'),
          backgroundColor: MyColors.backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImportantContacts()));
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ContactsWidget(
            contacts: [],
          ),
        ));
  }
}
