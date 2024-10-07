class LostModel {
  final String title;
  final String location;
  final String description;
  final String imageURL;
  final String compressedImageURL;
  final String phonenumber;
  final String email;
  final DateTime date;
  final String id;

  // Constructor
  const LostModel({
    required this.title,
    required this.description,
    required this.location,
    required this.imageURL,
    required this.email,
    required this.compressedImageURL,
    required this.date,
    required this.id,
    required this.phonenumber,
  });

  // Manual fromJson method
  factory LostModel.fromJson(Map<String, dynamic> json) {
    return LostModel(
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      imageURL: json['imageURL'] as String,
      email: json['email'] as String,
      compressedImageURL: json['compressedImageURL'] as String,
      date: DateTime.parse(
          json['date'] as String), // Parsing date string to DateTime
      id: json['_id'] as String, // '_id' key for id
      phonenumber: json['phonenumber'] as String, // phonenumber key
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
      'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
      '_id': id, // '_id' for id
      'phonenumber': phonenumber,
    };
  }
}
