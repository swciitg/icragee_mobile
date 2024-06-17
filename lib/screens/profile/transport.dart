import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/colors.dart';

import '../../widgets/contacts_widget.dart';

class Transport extends StatelessWidget {
  const Transport({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ContactsWidget(
            title: 'Transport',
            contacts: [],
          ),
        ));
  }
}
