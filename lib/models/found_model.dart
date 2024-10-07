class FoundModel {
  final String title;
  final String location;
  final String description;
  final String imageURL;
  final String compressedImageURL;
  final DateTime date;
  final String email;
  final String submitdate;
  bool claimed;
  String claimerEmail;
  String claimerName;
  final String id;

  // Constructor
  FoundModel({
    required this.title,
    required this.description,
    required this.location,
    required this.imageURL,
    required this.email,
    required this.compressedImageURL,
    required this.date,
    required this.submitdate,
    required this.claimed,
    required this.claimerEmail,
    required this.claimerName,
    required this.id,
  });

  // Manual fromJson method
  factory FoundModel.fromJson(Map<String, dynamic> json) {
    return FoundModel(
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      imageURL: json['imageURL'] as String,
      email: json['email'] as String,
      compressedImageURL: json['compressedImageURL'] as String,
      date: DateTime.parse(json['date'] as String),
      submitdate: json['submitdate'] as String,
      claimed: json['claimed'] as bool,
      claimerEmail: json['claimerEmail'] as String,
      claimerName: json['claimerName'] as String,
      id: json['_id'] as String,
    );
  }

  // Manual toJson method
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'imageURL': imageURL,
      'email': email,
      'compressedImageURL': compressedImageURL,
      'date': date.toIso8601String(), // Convert DateTime to string
      'submitdate': submitdate,
      'claimed': claimed,
      'claimerEmail': claimerEmail,
      'claimerName': claimerName,
      '_id': id,
    };
  }
}
