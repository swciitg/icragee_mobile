import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/faq.dart';

class DataService {
  Future<List<Faqs>> fetchFaqs() async {
   

    var collectionSnapshot =
        await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs
        .map((doc) => Faqs.fromJson(doc.data()))
        .toList();
  }
}
