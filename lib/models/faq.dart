//import 'dart:convert';

class Faqs {
  final String question;
  final String answer;

  Faqs({required this.question, required this.answer});

  Faqs.fromJson(Map<String, dynamic> faqs)
      : question = faqs['Question'],
        answer = faqs['Answer'];

  Map<String, dynamic> toJson() => {
        'Question': question,
        'Answer': answer,
      };
}
