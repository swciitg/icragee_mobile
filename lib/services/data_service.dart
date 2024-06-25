import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/faq.dart';

class DataService {
  Future<List<Faqs>> fetchFaqs() async {
    /*String jsonString = '''
    [
      {"Question": "What is Dart?", "Answer": "Dart is a programming language."},
      {"Question": "What is Flutter?", "Answer": "Flutter is a framework for building natively compiled applications."}
    ]
    ''';

    List<dynamic> faqData = jsonDecode(jsonString);
    List<Faqs> faqsList = faqData.map((faq) => Faqs.fromJson(faq)).toList();*/

    var collectionSnapshot =
        await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs
        .map((doc) => Faqs.fromJson(doc.data()))
        .toList();
  }
}
