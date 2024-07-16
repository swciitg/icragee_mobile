class FaqContent {
  final String question;
  final String answer;

  FaqContent({required this.question, required this.answer});

  factory FaqContent.fromJson(Map<String, dynamic> json) {
    return FaqContent(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
      };
}
