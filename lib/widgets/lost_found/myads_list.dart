import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/lost_found_model.dart';
import 'package:icragee_mobile/widgets/lost_found/lost_or_found_item_card.dart';

class MyAdsList extends ConsumerWidget {
  const MyAdsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('lost_found_items')
            .where('submittedBy', isEqualTo: user.id)
            .orderBy('submittedAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No items found"));
          }
          final items = snapshot.data!.docs
              .map((e) => LostFoundModel.fromJson(
                    e.data()! as Map<String, dynamic>,
                  ))
              .toList();
          return ListView(
            children: items.map((item) {
              return LostOrFoundItemCard(item: item, deleteOption: true);
            }).toList(),
          );
        },
      ),
    );
  }
}
